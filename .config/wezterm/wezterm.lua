local wezterm = require 'wezterm'
local act = wezterm.action
local tab_view_state = {}

local function tab_key(tab)
  if not tab then
    return nil
  end
  local ok, id = pcall(function()
    return tab:tab_id()
  end)
  if ok and id ~= nil then
    return tostring(id)
  end
  return tostring(tab)
end

local function infer_stacked_view(tab)
  if not tab then
    return false
  end
  local ok, zoomed_pane = pcall(function()
    return tab:get_zoomed_pane()
  end)
  return ok and zoomed_pane ~= nil
end

local function is_stacked_view(tab)
  local key = tab_key(tab)
  if not key then
    return true
  end
  if tab_view_state[key] == nil then
    -- Default to stacked view if state is not explicitly set
    tab_view_state[key] = true
  end
  return tab_view_state[key]
end

local function set_stacked_view(tab, value)
  local key = tab_key(tab)
  if key then
    tab_view_state[key] = value and true or false
  end
end

local function normalize_path(s)
  if not s then return "" end
  local out = tostring(s):gsub("\\", "/")
  out = out:gsub("^file://", "")
  out = out:gsub("/$", "")
  return out:lower()
end

local function canonical_path(s)
  local p = normalize_path(s)
  if p:match("^/[a-z]/") then
    p = p:gsub("^/([a-z])/", "%1:/")
  end
  p = p:gsub("^([a-z]):/%1/", "%1:/")
  return p
end

local function repo_name_from_path(s)
  local p = canonical_path(s)
  return p:match("([^/]+)$") or p
end

local function list_projects()
  local userprofile = os.getenv("USERPROFILE") or ""
  if userprofile == "" then
    return {}
  end

  local root1 = userprofile .. "\\dev\\work_repos"
  local root2 = userprofile .. "\\dev\\repos"
  local ps = table.concat({
    "$ErrorActionPreference='SilentlyContinue'",
    "$roots=@('" .. root1 .. "','" .. root2 .. "')",
    "foreach($r in $roots){ if(Test-Path $r){ Get-ChildItem -Path $r -Directory | ForEach-Object { $_.FullName } } }"
  }, ";")

  local success, stdout, _ = wezterm.run_child_process({
    "powershell",
    "-NoProfile",
    "-Command",
    ps,
  })

  if not success or not stdout then
    return {}
  end

  local choices = {}
  for line in stdout:gmatch("[^\r\n]+") do
    local raw_path = tostring(line):gsub("^%s+", ""):gsub("%s+$", "")
    local norm_path = normalize_path(raw_path)
    if norm_path ~= "" then
      local name = norm_path:match("([^/]+)$") or norm_path
      table.insert(choices, { id = raw_path, label = name .. "  [" .. norm_path .. "]" })
    end
  end

  table.sort(choices, function(a, b)
    return a.label < b.label
  end)

  return choices
end

local function open_or_focus_project(window, pane, cwd)
  local selected_path = tostring(cwd)
  local match_cwd = canonical_path(selected_path)
  local repo_name = repo_name_from_path(selected_path)
  local found_tab_index = nil
  local found_tab = nil
  local tabs = window:mux_window():tabs()

  for idx, t in ipairs(tabs) do
    local panes = t:panes()
    for _, p in ipairs(panes) do
      local tab_cwd = canonical_path(p and p:get_current_working_dir())
      if tab_cwd ~= "" and (tab_cwd:find(match_cwd, 1, true) or match_cwd:find(tab_cwd, 1, true)) then
        found_tab_index = idx - 1
        found_tab = t
        break
      end
    end
    if found_tab_index ~= nil then
      break
    end
  end

  if found_tab_index ~= nil then
    if found_tab then
      pcall(function()
        found_tab:set_title(repo_name)
      end)
    end
    wezterm.log_info("switching to existing tab index: " .. tostring(found_tab_index))
    window:perform_action(act.ActivateTab(found_tab_index), pane)
    return
  end

  wezterm.log_info("spawning new tab for cwd: " .. selected_path)
  local new_tab, shell_pane = window:mux_window():spawn_tab {
    set_environment_variables = {
      CHERE_INVOKING = "1",
    },
    args = { "C:/msys64/msys2_shell.cmd",
             "-where", selected_path,
             "-here",
             "-defterm",
             "-no-start",
             "-ucrt64",
             "-use-full-path",
             "-shell", "zsh" }
  }

  if new_tab then
    pcall(function()
      new_tab:set_title(repo_name)
    end)
  end

  local nvim_pane = shell_pane:split{
    direction = "Right",
    size = 0.5,
    set_environment_variables = {
      CHERE_INVOKING = "1",
    },
    args = { "C:/msys64/msys2_shell.cmd",
             "-where", selected_path,
             "-here",
             "-defterm",
             "-no-start",
             "-ucrt64",
             "-use-full-path",
             "-shell", "zsh",
             "-c", "if command -v nvim >/dev/null 2>&1; then nvim; else echo 'nvim not found in PATH'; fi; exec zsh" }
  }

  if not nvim_pane then
    wezterm.log_info("failed to create bottom nvim pane")
    window:toast_notification("WezTerm", "Failed to create nvim pane", nil, 2200)
    return
  end

  -- Keep panes stacked visually: show one pane at a time.
  window:perform_action(act.ActivatePaneByIndex(0), shell_pane)
  window:perform_action(act.TogglePaneZoomState, shell_pane)
  set_stacked_view(window:mux_window():active_tab(), true)
end

wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
  local title = tab.tab_title
  if not title or title == "" then
    title = tab.active_pane and tab.active_pane.title or "shell"
  end
  local clipped = wezterm.truncate_right(title, math.max(1, max_width - 2))
  return { { Text = " " .. clipped .. " " } }
end)

local function toggle_vertical_pane(window, pane)
  wezterm.log_info("toggle_vertical_pane triggered")
  local tab = window:mux_window():active_tab()
  local panes = tab and tab:panes() or {}
  if #panes < 2 then
    wezterm.log_info("toggle_vertical_pane: less than 2 panes")
    window:toast_notification("WezTerm", "No second pane in active tab", nil, 1800)
    return
  end

  local stacked_view = is_stacked_view(tab)

  if stacked_view then
    -- Stacked: unzoom, switch, re-zoom
    window:perform_action(act.TogglePaneZoomState, pane)
    wezterm.time.call_after(0.05, function()
      window:perform_action(act.ActivatePaneDirection("Next"), pane)
      wezterm.time.call_after(0.05, function()
        local current_tab = window:mux_window():active_tab()
        local next_pane = current_tab and current_tab:active_pane()
        if next_pane then
          window:perform_action(act.TogglePaneZoomState, next_pane)
        end
      end)
    end)
    set_stacked_view(tab, true)
    wezterm.log_info("toggle_vertical_pane mode=stacked")
  else
    window:perform_action(act.ActivatePaneDirection("Next"), pane)
    set_stacked_view(tab, false)
    wezterm.log_info("toggle_vertical_pane mode=split")
  end
end

local function debug_project_tab(window, pane)
  local tab = window:mux_window():active_tab()
  local panes = tab and tab:panes() or {}
  local nvim_found = false

  for _, p in ipairs(panes) do
    local ok, proc = pcall(function()
      return p:get_foreground_process_name()
    end)
    local proc_name = ""
    if ok and proc then
      proc_name = tostring(proc):lower()
    end
    if proc_name:find("nvim", 1, true) then
      nvim_found = true
    end
  end

  local msg = "panes=" .. tostring(#panes) .. " nvim=" .. tostring(nvim_found) .. " stacked=" .. tostring(is_stacked_view(tab))
  wezterm.log_info("project tab debug: " .. msg)
  window:toast_notification("WezTerm", msg, nil, 2200)
end

local function toggle_view_mode(window, pane)
  local tab = window:mux_window():active_tab()
  window:perform_action(act.TogglePaneZoomState, pane)
  set_stacked_view(tab, not is_stacked_view(tab))
end

local function goto_project(window, pane)
  wezterm.log_info("goto_project triggered")
  local choices = list_projects()
  if #choices == 0 then
    window:toast_notification("WezTerm", "No projects found under ~/dev/work_repos or ~/dev/repos", nil, 2500)
    return
  end

  window:perform_action(act.InputSelector {
    title = "Goto Project (type to filter)",
    fuzzy = true,
    choices = choices,
    action = wezterm.action_callback(function(inner_window, inner_pane, id, _label)
      if not id or id == "" then
        wezterm.log_info("project selection cancelled")
        return
      end
      open_or_focus_project(inner_window, inner_pane, id)
    end),
  }, pane)
end

return {
  -- Helpful while troubleshooting keybindings/callbacks
  debug_key_events = true,

  set_environment_variables = {
    CHERE_INVOKING = "1",
  },

  -- Use MSYS2 zsh as default shell for new tabs/panes
  default_prog = { "C:/msys64/msys2_shell.cmd", "-here", "-defterm", "-no-start", "-ucrt64", "-use-full-path", "-shell", "zsh" },

  -- Give tab titles more room so repo names are readable.
  use_fancy_tab_bar = false,
  tab_max_width = 64,
  font_size = 13.0,

  -- Keybindings
  keys = {
    -- Ctrl+F opens project picker
    { key = "f", mods = "CTRL", action = wezterm.action_callback(goto_project) },

    -- Debug key to verify this config is loaded
    { key = "F12", mods = "NONE", action = wezterm.action_callback(function(window, _)
      wezterm.log_info("F12 debug binding triggered")
      window:toast_notification("WezTerm", "F12 binding works", nil, 1500)
    end) },

    -- Tab navigation (Ctrl+H/L)
    { key = "h", mods = "CTRL", action = act.ActivateTabRelative(-1) },
    { key = "l", mods = "CTRL", action = act.ActivateTabRelative(1) },

    -- Ctrl+T works in both modes: split view switches panes, stacked view swaps hidden pane
    { key = "t", mods = "CTRL", action = wezterm.action_callback(toggle_vertical_pane) },

    -- Toggle between stacked view and visible vertical split
    { key = "a", mods = "CTRL", action = wezterm.action_callback(toggle_view_mode) },

    -- Debug pane state (pane count + nvim presence)
    { key = "T", mods = "CTRL|SHIFT", action = wezterm.action_callback(debug_project_tab) },

    -- Toggle zoom of active pane
    { key = "Enter", mods = "CTRL|SHIFT", action = act.TogglePaneZoomState },

    -- Optional: split panes manually
    { key = "\\", mods = "CTRL", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "-", mods = "CTRL", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
  }
}

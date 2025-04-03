{pkgs, ...}: {
   programs.ssh.matchBlocks = {
     enable = true;
     "github.com" = {
        hostname = "github.com";
        identityFile  = "~/.ssh/id_rsa";
	extraOptions = ''
          AddKeysToAgent yes
          UseKeychain yes
	'';
     };
   };
}



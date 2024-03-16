let vars = import ./vars.nix;
in with vars; {
  shellScripts = [
    (writeShellScriptBin "install-emacs"
    ''
      ${
        if vars.isMac then
          "brew install emacs &&"
        else
          "pacman -S emacs-nox && "
      } +
      git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
      ~/.config/emacs/bin/doom install
    ''
    )
    (writeShellScriptBin "update-nix-mac" 
    ''
       sudo -i sh -c 'nix-channel --update && nix-env -iA nixpkgs.nix && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'
    ''
    )
  ];
}

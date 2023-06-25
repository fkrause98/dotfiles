let
  vars = import ./vars.nix;
in with vars; {
  shellScripts = [
      (writeShellScriptBin "install-emacs" ''
        ${if vars.isMac then "brew install emacs &&" else "pacman -S emacs-nox && "} +
        git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
        ~/.config/emacs/bin/doom install
      '')
  ];
}

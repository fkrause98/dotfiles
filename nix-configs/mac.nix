{ pkgs, self }: {
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  nix.enable = false;
  nixpkgs.config.allowUnfree = true;
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility. please read the changelog
  # before changing: `darwin-rebuild changelog`.
  system.stateVersion = 4;

  # Remap caps lock to control
  system.keyboard.remapCapsLockToControl = true;
  # The platform the configuration will be used on.
  # If you're on an Intel system, replace with "x86_64-darwin"
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Declare the user that will be running `nix-darwin`.
  users.users.fran = {
    name = "fran";
    home = "/Users/fran";
  };

  programs.zsh.enable = true;
  services.emacs.enable = false;
  system.keyboard.enableKeyMapping = true;
  environment.systemPackages = with pkgs; [
    helix
    delta
    cmake
    fastfetch
    vim
    asdf-vm
    wxGTK32
    erlang-ls
    elixir-ls
    iterm2
    libiconv
    just
    rustup
    apple-sdk
    (import ./lsp-booster.nix { pkgs = pkgs; })
    emacs
    go
    glibtool
  ];

  homebrew = {
    enable = true;
    taps = [ "shaunsingh/SFMono-Nerd-Font-Ligaturized" ];
    brews = [ "mosh" "docker" "pinentry-mac" ];
    casks = [ "tg-pro" "iterm2" "font-sf-mono-nerd-font-ligaturized" ];
    onActivation.extraFlags = [ "--verbose" ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;
  # Enable tap to click
  system.defaults.trackpad.Clicking = true;
  # system.defaults.trackpad.Clicking = true;
  # Enable Rosetta 2
  system.activationScripts.extraActivation.text = ''
    softwareupdate --install-rosetta --agree-to-license
  '';
}

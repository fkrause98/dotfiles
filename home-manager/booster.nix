{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/«version»";
    emacs-lsp-booster.url = "github:slotThe/emacs-lsp-booster-flake";
    # The emacs-lsp-booster flake itself depends on `nixpkgs`; you
    # might want to make this input follow the one in your
    # configuration.
    #
    # emacs-lsp-booster.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { emacs-lsp-booster, ...}:
    let my-overlays = {
          nixpkgs.overlays = [
            «other-overlays»
            emacs-lsp-booster.overlays.default
          ];
        };
    in {
      nixosConfigurations.«hostname» = nixpkgs.lib.nixosSystem rec {
        system = «system»;
        modules = [
          «other-modules»
          my-overlays
        ];
      };
    };
}
}

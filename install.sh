#!/bin/sh
set -e
set -o pipefail
set -x
# Install Nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon --yes

# Check that Nix is properly working
if nix-instantiate '<nixpkgs>' -A hello; then
  echo "Nix is properly working"
else
  echo "Nix is not working as expected"
  exit 1
fi

# Add home-manager channel
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# Install home-manager
nix-shell '<home-manager>' -A install

# Remove the generated home.nix file and symlink the local one
rm ~/.config/home-manager/home.nix
ln -s $(pwd)/home.nix ~/.config/home-manager/home.nix

# Run home-manager
home-manager switch

# Now we should have emacs and be ready to install doom:
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

# Remove default config and link mine
rm -rf ~/.config/doom
ln -s $(pwd)/doom-emacs ~/.config/doom
~/.config/emacs/bin/doom sync

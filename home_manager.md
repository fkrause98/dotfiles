## Install Nix
```sh
 sh <(curl -L https://nixos.org/nix/install) --no-daemon --yes
```
## Install Home-manager
Check with:
```sh
 nix-instantiate '<nixpkgs>' -A hello
```
That nix is properly working
Add home-manager channel:
```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager &&
nix-channel --update
```
Install home-manager:
```sh
nix-shell '<home-manager>' -A install
```
Finally, remove the generated home.nix file and symlink the local one:
```sh
$ rm ~/.config/home-manager/home.nix
$ ln -s ~/dotfiles/home.nix ~/.config/home-manager/home.nix
```

Run home-manager:
```sh
$ home-manager switch
```

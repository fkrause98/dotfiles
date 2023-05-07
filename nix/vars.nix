{
isMac = builtins.currentSystem == "darwin";
isLinux = builtins.currentSystem == "x86_64-linux";
home = builtins.getEnv "HOME";
user = builtins.getEnv "USER";
emacsConfig = ../doom-emacs;
}

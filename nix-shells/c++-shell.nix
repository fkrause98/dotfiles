{ pkgs ? import <nixpkgs> {}, buildInputs ? [], shellHook ? "", ... }@attrs:

let
  llvmPackage = pkgs.llvmPackages_18;
  stdenv = llvmPackage.libcxxStdenv;
  libcxx = llvmPackage.libraries.libcxx;
  clang-python = llvmPackage.clang-unwrapped.python;

  rest = builtins.removeAttrs attrs ["pkgs" "buildInputs" "shellHook"];

  extraBuildInputs = buildInputs;
  localBuildInputs = [libcxx clang-python llvmPackage.lldb];
  extraShellHook = shellHook;

in stdenv.mkDerivation (rec {
  name = "libcxxStdenv";
  buildInputs = localBuildInputs ++ extraBuildInputs;
  shellHook = ''
    export CPATH=$CPATH:${llvmPackage.libcxx}/include/c++/v1:${llvmPackage.stdenv}/include
    export CPLUS_INCLUDE_PATH=$CPATH
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${libcxx}/lib
    export PATH=$PATH:${clang-python}/share/clang
  '' + extraShellHook;
  CPATH = pkgs.lib.makeSearchPathOutput "dev" "include" (localBuildInputs ++ extraBuildInputs);
} // rest)

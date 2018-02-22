{ pkgs ? import <nixpkgs> {} }:

with pkgs;
stdenv.mkDerivation {
  name = "os_vaje";
  buildInputs = [ guile ];
}

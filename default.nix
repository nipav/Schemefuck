{ pkgs ? import <nixpkgs> {} }:

with pkgs;
stdenv.mkDerivation {
  name = "schemefuck";
  buildInputs = [ guile ];
}

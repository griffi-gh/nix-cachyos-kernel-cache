{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable-small";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
  };

  outputs = { nixpkgs, nix-cachyos-kernel, ... }: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        nix-cachyos-kernel.overlays.default
      ];
    };
  in {
    checks.${system} = {
      inherit (pkgs.cachyosKernels.linuxPackages-cachyos-latest) kernel;
    };
  };
}

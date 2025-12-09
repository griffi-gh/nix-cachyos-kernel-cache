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
    checks.${system} = pkgs.lib.pipe pkgs.cachyosKernels.linuxPackages-cachyos-latest [
      (pkgs.lib.mapAttrs (_: v: builtins.tryEval v))
      (pkgs.lib.filterAttrs (_: res: res.success))
      (pkgs.lib.mapAttrs (_: res: res.value))
      (pkgs.lib.filterAttrs (_: v: pkgs.lib.isDerivation (v.kernel or null)))
    ];
  };
}

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable-small";
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nix-cachyos-kernel, ... }: 
    checks."x86_64-linux" = {
      inherit (pkgs.cachyosKernels.linuxPackages-cachyos-latest) kernel;
    };
  };
}

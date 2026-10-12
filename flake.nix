{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f (import nixpkgs {inherit system;}));
  in {
    packages = forAllSystems (
      pkgs: let
        pkgList = with pkgs; [
          lua-language-server
          alejandra
          stylua
          nixd

          lua5_1
          tree-sitter
          gcc
          cargo
          gnumake
          ripgrep
          luarocks
        ];
      in {
        default = inputs.wrappers.wrappers.neovim.wrap {
          inherit pkgs;
          env = {
            "CONFIG_ROOT" = ./.;
            "NVIM_APPNAME" = "nvim-ow1cfg-remote";
          };
          runtimePkgs = pkgList;
          settings.config_directory = ./.;
        };
      }
    );
  };
}

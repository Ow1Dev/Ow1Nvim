{
  description = "Neovim configuration with lazy.nvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
          withPython3 = true;
          withNodeJs = true;
          withRuby = true;
          viAlias = true;
          vimAlias = true;
        };

        myNeovim = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (neovimConfig // {
          wrapperArgs = neovimConfig.wrapperArgs ++ [
            "--prefix" "PATH" ":" "${pkgs.lib.makeBinPath [ pkgs.git ]}"
          ];
          wrapRc = false;
        });

        # Development version - uses temporary directory
        devNeovim = pkgs.writeShellScriptBin "nvim" ''
          # Create temporary directory for this session
          export NVIM_TEMP_DIR=$(mktemp -d -t nvim-flake-XXXXXX)
          trap "rm -rf $NVIM_TEMP_DIR" EXIT
          
          export XDG_CONFIG_HOME="$NVIM_TEMP_DIR"
          export XDG_DATA_HOME="$NVIM_TEMP_DIR/data"
          export XDG_STATE_HOME="$NVIM_TEMP_DIR/state"
          
          mkdir -p "$XDG_CONFIG_HOME/nvim-flake"
          mkdir -p "$XDG_DATA_HOME"
          mkdir -p "$XDG_STATE_HOME"
          
          # Copy config files to temp location
          cp ${./init.lua} "$XDG_CONFIG_HOME/nvim-flake/init.lua"
          cp -r ${./lua} "$XDG_CONFIG_HOME/nvim-flake/lua"
          
          export NVIM_APPNAME="nvim-flake"
          exec ${myNeovim}/bin/nvim "$@"
        '';

        # Installed version - uses permanent directory
        installedNeovim = pkgs.stdenv.mkDerivation {
          name = "neovim-flake-config";
          src = ./.;
          
          installPhase = ''
            mkdir -p $out/bin
            mkdir -p $out/share/nvim
            
            # Copy config files
            cp -r ${./init.lua} $out/share/nvim/init.lua
            cp -r ${./lua} $out/share/nvim/lua
            
            # Create wrapper script for installed version
            cat > $out/bin/nvim <<EOF
            #!/bin/sh
            export XDG_CONFIG_HOME="\''${XDG_CONFIG_HOME:-\$HOME/.config}"
            mkdir -p "\$XDG_CONFIG_HOME/nvim-flake"
            
            # Symlink our config if not already present
            if [ ! -e "\$XDG_CONFIG_HOME/nvim-flake/init.lua" ]; then
              ln -sf $out/share/nvim/init.lua "\$XDG_CONFIG_HOME/nvim-flake/init.lua"
            fi
            if [ ! -e "\$XDG_CONFIG_HOME/nvim-flake/lua" ]; then
              ln -sf $out/share/nvim/lua "\$XDG_CONFIG_HOME/nvim-flake/lua"
            fi
            
            export NVIM_APPNAME="nvim-flake"
            exec ${myNeovim}/bin/nvim "\$@"
            EOF
            
            chmod +x $out/bin/nvim
          '';
        };

      in {
        # Use dev version for nix run
        packages.default = devNeovim;
        packages.installed = installedNeovim;

        apps.default = {
          type = "app";
          program = "${devNeovim}/bin/nvim";
        };

        # For home-manager integration - uses installed version
        homeManagerModules.default = { config, lib, pkgs, ... }: {
          options.programs.neovim-flake = {
            enable = lib.mkEnableOption "Neovim flake configuration";
          };

          config = lib.mkIf config.programs.neovim-flake.enable {
            home.packages = [ self.packages.${system}.installed ];
            
            # Optional: make it the default nvim
            home.shellAliases = {
              vim = "nvim";
              vi = "nvim";
            };
          };
        };
      }
    );
}

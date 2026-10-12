# NVIM for Ow1

# Trying
To try the config:
```sh
nix run git+https://github.com/Ow1Dev/Ow1Nvim
```  

# Installing
Add the input to your flake:
```nix
{
    inputs = {
        nvim-ow1.url = "git+https://github.com/Ow1Dev/Ow1Nvim"
    }
}
```  
And then add the package to your system config:

```nix
inputs.nvim-ow1.packages.${stdenv.hostPlatform.system}.default
```  



   



{
  description = "Neovim configuration";

  outputs = { self }: {

    homeManagerModules.default = { config, lib, pkgs, ... }: {
      xdg.configFile."nvim" = {
        source = ./.;
        recursive = true;
      };
    };
  };
}

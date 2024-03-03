{
  imports = [ ./keybinds.nix ];
  programs.nixvim.plugins.lspsaga = {
    enable = true;

    ui = {
      title = false;
      border = "rounded";
    };

    rename = {
      inSelect = false;
      autoSave = true;
      keys = {
        quit = "<esc>";
      };
    };

    hover = {
      openLink = "<CR>";
      openCmd = "!firefox";
    };

    symbolInWinbar = {
      separator = " ";
      hideKeyword = true;
      folderLevel = 2;
    };

    beacon.enable = false;
    lightbulb.enable = false;
  };
}

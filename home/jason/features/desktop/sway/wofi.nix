{ pkgs, ... }:

{
  programs.wofi = {
    enable = true;
    package = pkgs.wofi.overrideAttrs (oa: {
      patches = (oa.patches or [ ]) ++ [
        ./wofi-run-shell.patch # Fix for https://todo.sr.ht/~scoopta/wofi/174
      ];
    });
    settings = {
      image_size = 48;
      columns = 1;
      allow_images = true;
      insensitive = true;
      key_up = "Ctrl-p";
      key_down = "Ctrl-n";
      run-always_parse_args = true;
      run-cache_file = "/dev/null";
      run-exec_search = true;
      show = "drun";
      prompt = "";
    };

    style = /* css */ ''
      * {
        font-family: monospace;
      }

      window {
        background-color: #323232;
      }

      #input {
        margin: 5px;
        border-radius: 0px;
        border: none;
        background-color: #323232;
        color: white;
      }

      #scroll {}

      #text {
        padding: 5px;
        color: white;
      }

      #entry {
        background-color: #323232;
      }

      #entry:selected {
        background-color: #4c7899;
      }

      #text:selected {}
    '';
  };
}

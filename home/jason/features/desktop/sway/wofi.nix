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
  };
}

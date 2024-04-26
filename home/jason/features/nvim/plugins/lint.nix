{ pkgs, ... }:

{
  programs.nixvim = {
    extraPackages = with pkgs;[
      nodePackages_latest.eslint_d
      selene
      python311Packages.flake8
      sqlfluff
      ansible-lint
      djlint
      golangci-lint
    ];

    plugins.lint = {
      enable = true;
      autoCmd.event = [ "InsertLeave" "TextChanged" "BufRead" "BufWrite" ];

      linters = {
        sqlfluff = {
          cmd = "sqlfluff";
          args = [
            "lint"
            "--format=json"
            "--dialect=postgres"
          ];
        };
      };

      lintersByFt = {
        python = [ "flake8" ];
        lua = [ "selene" ];
        luau = [ "selene" ];
        sql = [ "sqlfluff" ];
        yml = [ "ansible_lint" ];
        yaml = [ "ansible_lint" ];
        htmldjango = [ "djlint" ];
        go = [ "golangcilint" ];
      };
    };
  };
}

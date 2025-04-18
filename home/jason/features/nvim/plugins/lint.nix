{ pkgs, ... }:

{
  programs.nixvim = {
    extraPackages = with pkgs;
      [
        selene
        python313Packages.flake8
        sqlfluff
        yamllint
        djlint
        golangci-lint
        tflint
        hadolint
        proselint
        codespell
        actionlint
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
        "*" = [ "codespell" ];
        python = [ "flake8" ];
        lua = [ "selene" ];
        luau = [ "selene" ];
        sql = [ "sqlfluff" ];
        yml = [ "yamllint" ];
        yaml = [ "yamllint" ];
        markdown = [ "proselint" ];
        dockerfile = [ "hadolint" ];
        htmldjango = [ "djlint" ];
        go = [ "golangcilint" ];
        terraform = [ "tflint" ];
        "yaml.ghaction" = [ "actionlint" "yamllint" ];
      };
    };

    keymaps = [
      {
        mode = [ "n" ];
        key = "<Leader>sl";
        action = /* lua */ ''
          function()
            print(table.concat(require('lint').get_running(), ", "))
          end
        '';
        lua = true;
        options = {
          silent = true;
          desc = "Show Linters";
        };
      }
    ];
  };
}

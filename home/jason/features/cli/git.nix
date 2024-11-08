{ pkgs, ... }:

{
  home.packages = [ pkgs.github-cli pkgs.git-crypt ];

  programs.git = {
    enable = true;
    userName = "jasonpanosso";
    userEmail = "jasonpanosso@protonmail.com";
    lfs.enable = true;
    difftastic.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
      user.signingkey = "7F4BBBCE5FA232F9DC9E6707CD4B7B6A06A225FD";
      # commit.gpgSign = true;
      merge.conflictStyle = "zdiff3";
      commit.verbose = true;
      diff.algorithm = "histogram";
      log.date = "iso";
      column.ui = "auto";
      branch.sort = "committerdate";
      push.autoSetupRemote = true;
      rerere.enabled = true; # Reuse merge conflict fixes when rebasing
      pull.rebase = true;
    };

    aliases = {
      ci = "commit";
      co = "checkout";
      st = "status";
      fk = "commit --amend --no-edit";
      push-with-lease = "push --force-with-lease";
      review-local = "!git lg @{push}..";
      uncommit = "reset --soft HEAD~1";
      untrack = "rm --cache --";
    };

    ignores = [
      "*.com"
      "*.class"
      "*.dll"
      "*.exe"
      "*.o"
      "*.so"
      "*.pyc"
      "*.pyo"
      "*.7z"
      "*.dmg"
      "*.gz"
      "*.iso"
      "*.jar"
      "*.rar"
      "*.tar"
      "*.tar.gz"
      "*.zip"
      "*.msi"
      "*.log"
      ".direnv"
      ".DS_Store"
      ".DS_Store?"
      "._*"
      ".Trashes"
      "ehthumbs.db"
      "Thumbs.db"
      "desktop.ini"
      "*.bak"
      "*.swp"
      "*.swo"
      "*~"
      "*#"
      "result"
      "npm-debug.log"
      "log/"
      "luac.out"
      "__pycache__/"
      "*.py[cod]"
      "*$py.class"
      ".Python"
      "build/"
      "develop-eggs/"
      "dist/"
      "downloads/"
      "eggs/"
      ".eggs/"
      "lib64/"
      "parts/"
      "sdist/"
      "var/"
      "wheels/"
      "share/python-wheels/"
      "*.egg-info/"
      ".installed.cfg"
      "*.egg"
      "MANIFEST"
      "*.so"
      "*.manifest"
      "*.spec"
      "pip-log.txt"
      "pip-delete-this-directory.txt"
      "htmlcov/"
      ".tox/"
      ".nox/"
      ".coverage"
      ".coverage.*"
      ".cache"
      "nosetests.xml"
      "coverage.xml"
      "*.cover"
      "*.py,cover"
      ".hypothesis/"
      ".pytest_cache/"
      "cover/"
      "*.mo"
      "*.pot"
      "*.log"
      "local_settings.py"
      "db.sqlite3"
      "db.sqlite3-journal"
      "instance/"
      ".webassets-cache"
      ".scrapy"
      "docs/_build/"
      ".pybuilder/"
      "target/"
      "profile_default/"
      "ipython_config.py"
      ".env"
      ".venv"
      "env/"
      "venv/"
      "ENV/"
      "env.bak/"
      "venv.bak/"
      "/site"
      ".pytype/"
      "cython_debug/"
      "logs"
      "*.log"
      "npm-debug.log*"
      "yarn-debug.log*"
      "yarn-error.log*"
      "lerna-debug.log*"
      ".pnpm-debug.log*"
      "report.[0-9]*.[0-9]*.[0-9]*.[0-9]*.json"
      "pids"
      "*.pid"
      "*.seed"
      "*.pid.lock"
      "lib-cov"
      "coverage"
      "*.lcov"
      "build/Release"
      "node_modules/"
      "jspm_packages/"
      "web_modules/"
      "*.tsbuildinfo"
      ".npm"
      ".eslintcache"
      ".stylelintcache"
      ".rpt2_cache/"
      ".rts2_cache_cjs/"
      ".rts2_cache_es/"
      ".rts2_cache_umd/"
      ".node_repl_history"
      "*.tgz"
      ".yarn-integrity"
      ".env"
      ".env.development.local"
      ".env.test.local"
      ".env.production.local"
      ".env.local"
      ".cache"
      ".parcel-cache"
      ".next"
      "out"
      ".nuxt"
      "dist"
      ".cache/"
      ".vuepress/dist"
      ".temp"
      ".cache"
      ".docusaurus"
      ".serverless/"
      ".fusebox/"
      ".dynamodb/"
      ".tern-port"
      ".yarn/cache"
      ".yarn/unplugged"
      ".yarn/build-state.yml"
      ".yarn/install-state.gz"
      ".pnp.*"
      ".Trash-*"
      ".fuse_hidden*"
      ".nfs*"
      ".directory"
      "parts/"
      "prime/"
      "stage/"
      "/snap/.snapcraft/"
      "/*_source.tar.bz2"
    ];
  };
}

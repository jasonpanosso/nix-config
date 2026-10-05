{ pkgs, ... }:

let
  winGit = "/mnt/c/Program Files/Git/cmd/git.exe";
  linuxGit = "${pkgs.git}/bin/git";

  # use git.exe on windows drives (/mnt/x)
  wrapper = pkgs.writeShellScript "git" ''
    case "$PWD" in
      /mnt/[a-z]/*) ;;
      *) exec ${linuxGit} "$@" ;;
    esac
    [ -x "${winGit}" ] || exec ${linuxGit} "$@"

    sub= i=1
    while [ "$i" -le "$#" ]; do
      case "''${!i}" in
        -C|-c) i=$((i + 2)) ;;
        -*) i=$((i + 1)) ;;
        *) sub="''${!i}"; break ;;
      esac
    done

    case "$sub" in
      rev-parse|worktree) exec ${linuxGit} "$@" ;;
    esac

    args=()
    for a in "$@"; do
      case "$a" in
        /mnt/[a-z]/*) args+=("$(/sbin/wslpath -w "$a")") ;;
        --*=/mnt/[a-z]/*) args+=("''${a%%=*}=$(/sbin/wslpath -w "''${a#*=}")") ;;
        *) args+=("$a") ;;
      esac
    done

    export WSLENV="''${WSLENV:+$WSLENV:}GIT_EDITOR:GIT_SEQUENCE_EDITOR:GIT_TERMINAL_PROMPT"
    exec "${winGit}" "''${args[@]}"
  '';

  gitWsl = pkgs.symlinkJoin {
    name = "git-wsl-${pkgs.git.version}";
    paths = [ pkgs.git ];
    postBuild = ''
      rm $out/bin/git
      ln -s ${wrapper} $out/bin/git
    '';
  };
in
{
  programs.git.package = gitWsl;
}

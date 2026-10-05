{ pkgs, config, ... }:

let
  pinentry =
    if config.gtk.enable then {
      homePackages = [ pkgs.pinentry-gnome3 pkgs.gcr_4 ];
      package = pkgs.pinentry-gnome3;
      name = "gnome3";
    } else {
      homePackages = [ pkgs.pinentry-curses pkgs.gcr_4 ];
      package = pkgs.pinentry-curses;
      name = "curses";
    };
in
{
  home = {
    packages = pinentry.homePackages;
    shellAliases.gpg-unlock =
      "gpg-connect-agent updatestartuptty /bye >/dev/null && echo | gpg --clearsign -u 7F4BBBCE5FA232F9DC9E6707CD4B7B6A06A225FD >/dev/null && echo unlocked";
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pinentry.package;
    enableExtraSocket = true;
  };

  programs =
    let
      fixGpg = /* bash */ ''
        gpgconf --launch gpg-agent
      '';
    in
    {
      # Start gpg-agent if it's not running or tunneled in
      # SSH does not start it automatically, so this is needed to avoid having to use a gpg command at startup
      # https://www.gnupg.org/faq/whats-new-in-2.1.html#autostart
      bash.profileExtra = fixGpg;
      zsh.loginExtra = fixGpg;

      gpg = {
        enable = true;
        settings = {
          trust-model = "tofu+pgp";
        };
        publicKeys = [{
          source = ../../pgp.asc;
          trust = 5;
        }];
      };
    };

  systemd.user.services = {
    # Link /run/user/$UID/gnupg to ~/.gnupg-sockets
    # So that SSH config does not have to know the UID
    link-gnupg-sockets = {
      Unit = {
        Description = "link gnupg sockets from /run to /home";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
        ExecStop = "${pkgs.coreutils}/bin/rm ${config.home.homeDirectory}/.gnupg-sockets";
        RemainAfterExit = true;
      };
      Install.WantedBy = [ "default.target" ];
    };
  };
}

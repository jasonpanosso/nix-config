{ inputs, ... }:

{
  homeManager.profiles.apps =
    { pkgs, ... }:

    {
      stylix.targets.firefox.profileNames = [ "jason" ];

      programs.firefox = {
        enable = true;

        profiles.jason = {
          bookmarks = { };
          extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
            ublock-origin
            bitwarden
            reddit-enhancement-suite
            darkreader
            vimium
            clearurls
          ];

          settings = {
            "browser.disableResetPrompt" = true;
            "browser.download.panel.shown" = true;
            "browser.download.useDownloadDir" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.shell.checkDefaultBrowser" = false;
            "browser.shell.defaultBrowserCheckCount" = 1;
            "dom.security.https_only_mode" = true;
            "privacy.trackingprotection.enabled" = true;
          };
        };
      };

      xdg.mimeApps.defaultApplications = {
        "text/html" = [ "firefox.desktop" ];
        "text/xml" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
      };
    };
}

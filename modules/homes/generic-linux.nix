{
  inputs,
  config,
  withSystem,
  ...
}:

let
  inherit (config.flake.modules) homeManager;
in
{
  # `nh home switch` on any non-NixOS linux machine
  flake.homeConfigurations.jason = withSystem "x86_64-linux" (
    { pkgs, ... }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = with homeManager; [
        base
        jason
        linux
        shell
        nvim
        {
          targets.genericLinux.enable = true;

          # headless by default; add a desktop feature for a graphical clipboard/pinentry
          clipboard = {
            copy = "${pkgs.wl-clipboard}/bin/wl-copy";
            paste = "${pkgs.wl-clipboard}/bin/wl-paste --no-newline";
          };
          services.gpg-agent.pinentry.package = pkgs.pinentry-curses;
        }
      ];
    }
  );
}

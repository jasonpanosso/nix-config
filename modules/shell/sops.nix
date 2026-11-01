{
  homeManager.profiles.base =
    { lib, pkgs, ... }:
    {
      home.packages = with pkgs; [
        sops
        age
        age-plugin-yubikey # PIV
      ];

      # get identify of currently plugged in yubikey
      home.sessionVariables.SOPS_AGE_KEY_CMD = "${lib.getExe pkgs.age-plugin-yubikey} --identity";
    };
}

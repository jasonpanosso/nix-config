{
  imports = [
    ../common/global
    ../common/users/jason
    ../common/optional/docker.nix
  ];

  networking.hostName = "wsl";
}

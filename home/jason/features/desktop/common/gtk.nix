{
  gtk = {
    enable = true;

    theme.name = "Adwaita-dark";
    iconTheme = {
      name = "Papirus";
    };

    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme = true;
    '';
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = "Adwaita-dark";
      "Net/IconThemeName" = "Adwaita-dark";
    };
  };
}

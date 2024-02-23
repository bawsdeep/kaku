{config, ...}: let
  variant = config.theme.name;
  c = config.programs.matugen.theme.colors.colors.${variant};

  font_family = "Lexend";
in {
  programs.hyprlock = {
    enable = true;

    general.hide_cursor = false;

    backgrounds = [
      {
        monitor = "";
        path = "${config.home.homeDirectory}/Pictures/Wallpapers/lovelace.png";
      }
    ];

    input-fields = [
      {
        monitor = "HDMI-A-2";

        size = {
          width = 300;
          height = 50;
        };

        outline_thickness = 2;

        outer_color = "rgb(${c.primary})";
        inner_color = "rgb(${c.on_primary_container})";
        font_color = "rgb(${c.primary_container})";

        fade_on_empty = false;
        placeholder_text = ''<span font_family="${font_family}" foreground="##${c.primary_container}">Password...</span>'';

        dots_spacing = 0.3;
        dots_center = true;
      }
    ];

    labels = [
      {
        monitor = "";
        text = "$TIME";
        inherit font_family;
        font_size = 50;
        color = "rgb(${c.primary})";

        position = {
          x = 0;
          y = 80;
        };

        valign = "center";
        halign = "center";
      }
    ];
  };
}

{ pkgs, ... }:
{
    home.packages = with pkgs; [
        kdePackages.kate
        equibop
        jetbrains.idea
        prismlauncher
        gimp

        home-manager
        way-displays
    ];

    services.way-displays = {
        enable = true;

        settings = {
            ORDER = [
                "HDMI-A-1"
                "eDP-1"
            ];
            SCALING = false;
            MODE = [
                {
                    NAME_DESC = "HDMI-A-1";
                    WIDTH = 1920;
                    HEIGHT = 1080;
                    HZ = 144;
                }

                {
                    NAME_DESC = "eDP-1";
                    WIDTH = 2560;
                    HEIGHT = 1600;
                    HZ = 240;
                }
            ];
            SCALE = [
                {
                    NAME_DESC = "eDP-1";
                    SCALE = 1.25;
                }
            ];
        };
    };

    home.stateVersion = "25.11";
}
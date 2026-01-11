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

    home.stateVersion = "25.11";
}
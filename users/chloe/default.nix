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

    programs = {
        firefox.enable = true;
        git.enable = true;
        java = {
            enable = true;
            package = pkgs.jdk25;
        };

        steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
        };

        gnupg.agent = {
            enable = true;
            enableSSHSupport = true;
        };
    };
}
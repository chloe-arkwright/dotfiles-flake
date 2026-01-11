{ config, pkgs, ... }:

{
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = ["nix-command" "flakes"];

    imports = [ ./hardware-configuration.nix ];

    powerManagement.cpuFreqGovernor = "performance";

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "chloe-tuxedo"; # Define your hostname.
    networking.networkmanager.enable = true;

    time.timeZone = "Europe/London";
    i18n.defaultLocale = "en_GB.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_GB.UTF-8";
        LC_IDENTIFICATION = "en_GB.UTF-8";
        LC_MEASUREMENT = "en_GB.UTF-8";
        LC_MONETARY = "en_GB.UTF-8";
        LC_NAME = "en_GB.UTF-8";
        LC_NUMERIC = "en_GB.UTF-8";
        LC_PAPER = "en_GB.UTF-8";
        LC_TELEPHONE = "en_GB.UTF-8";
        LC_TIME = "en_GB.UTF-8";
    };

       services = {
            openssh.enable = true;
            libinput.enable = true;
            gpm.enable = true;

            xserver.enable = false;

            displayManager.sddm.enable = true;
            displayManager.sddm.wayland.enable = true;
            desktopManager.plasma6.enable = true;

            printing.enable = true;

            pipewire = {
                enable = true;
                alsa.enable = true;
                alsa.support32Bit = true;
                pulse.enable = true;
            };
        };

    # todo: figure out how to set keyboard layout on wayland / kde

    console.keyMap = "uk";

    security.rtkit.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment = {
        systemPackages = with pkgs; [ ];

        sessionVariables = {
            LD_LIBRARY_PATH = map (pkg: "${pkg}/lib") ( with pkgs; [
                # required for lwjgl games
                glfw
                libpulseaudio
                libGL
                openal
                stdenv.cc.cc
                udev # oshi
                flite # translator todo: not working
            ]);
        };
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?

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

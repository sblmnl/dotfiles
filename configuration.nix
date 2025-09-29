{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-eb3733e4-42a3-48d0-a7af-41d2dc0fc98f".device = "/dev/disk/by-uuid/eb3733e4-42a3-48d0-a7af-41d2dc0fc98f";  

  boot.initrd.luks.devices."luks-01c6ec40-8106-4503-ab2a-7dbfd53439b4".device = "/dev/disk/by-uuid/01c6ec40-8106-4503-ab2a-7dbfd53439b4";
  fileSystems."/media/Home" = {
    device = "/dev/disk/by-uuid/b315385b-cdba-4471-9b82-dd532c38f228";
    options = [ "auto" "nofail" "nodev" "nosuid" ];
  };

  boot.initrd.luks.devices."luks-88a6b901-6969-4f4f-a3c2-e91ec860d86b".device = "/dev/disk/by-uuid/88a6b901-6969-4f4f-a3c2-e91ec860d86b";
  fileSystems."/media/Data" = {
    device = "/dev/disk/by-uuid/26529d89-8020-4fe5-84f1-c4a137e8786e";
    options = [ "auto" "nofail" "nodev" "nosuid" ];
  };

  networking = {
    hostName = "subway";

    networkmanager.enable = true;

    interfaces.enp4s0.ipv4.addresses = [{
      address = "192.168.1.2";
      prefixLength = 24;
    }];

    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" "1.0.0.1" ];

    firewall.enable = true;
    firewall.allowedTCPPorts = [ 8096 ];
  };

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.pipewire.enable = false;
  services.pulseaudio.enable = true;
  services.pulseaudio.support32Bit = true;

  services.mpd = {
    enable = true;
    musicDirectory = "/media/Home/jared/Music";
    user = "jared";
    startWhenNeeded = true;
  };

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" "nvidia" ];
    excludePackages = with pkgs; [
      xterm
    ];
    xkb.options = "";
  };

  services.displayManager.ly = {
    enable = true;
    package = pkgs.ly;
  };

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "sorin";
      plugins = [ "git" "ssh-agent" ];
      preLoaded = ''
        zstyle :omz:plugins:ssh-agent lazy yes
        zstyle :omz:plugins:ssh-agent quiet yes
      '';
    };
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  programs.nix-ld.enable = true;

  users.users.jared = {
    isNormalUser = true;
    description = "jared";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      mullvad-browser
      firefox
      brave
      vscode
      jetbrains.rider
      nodejs_22
      dotnet-sdk_9
      qbittorrent
      keepassxc
      veracrypt
      rmpc
      libreoffice
      sweet
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    killall
    gnupg
    git
    wget
    eza
    kitty
    hypridle
    hyprlock
    hyprpaper
    hyprshot
    rofi-wayland
    waybar
    dunst
    xfce.thunar
    timeshift
    xarchiver
    pavucontrol
    playerctl
    nwg-look
    keyd
    dotnet-runtime_9
  ];

  fonts = {
    packages = with pkgs; [
      nerd-fonts.symbols-only
      nerd-fonts.hurmit
    ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "3553:c011:4eaf5201" ];
        settings = {
          main = {
            a = "playpause";
            b = "previoussong";
            c = "nextsong";
          };
        };
      };
    };
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  services.flatpak.enable = true;

  environment.sessionVariables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    graphics.enable = true;
    nvidia = {
      open = false;
      modesetting.enable = true;
    };
  };

  system.stateVersion = "25.05";
}

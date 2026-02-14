# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = false;
  boot.loader = {
    grub = {
      enable = true;
      splashImage = null;
      forceInstall = false;
      backgroundColor = "#000000";
      device = "nodev";
      efiSupport= true;
      useOSProber = false;
      theme = null;
    };

    timeout = 0;
  };
  boot.loader.efi.canTouchEfiVariables = true; 

  
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Amsterdam";

  fonts.packages = with pkgs; [
    quicksand
    google-fonts 
    font-awesome
];

  # 2. Set Quicksand as the default
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Quicksand" ];
      monospace = [ "DejaVu Sans Mono" ]; # Keep a good monospace font for terminal
    };
  };  

# Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de_CH-latin1";
    # useXkbConfig = true; # use xkb.options in tty.
  };


  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = false;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };  

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # AGS Requirements
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.selim = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
    initialPassword = "1234";
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    git
    kitty
    swww
    wl-clipboard
    wl-clip-persist
    nautilus
    brave
    slurp
    grim
    brightnessctl
    mission-center
  ];

  security.polkit.enable = true;



  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # Also add this to fix that portal warning in your logs
  xdg.portal.config.common.default = "*";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}


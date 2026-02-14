{ pkgs, ... }:

{
  imports = [
    ../../options.nix
    ./hardware-configuration.nix  # The hardware scan you just moved
    ../../common.nix             # Your shared settings
  ];

  networking.hostName = "laptop"; # Unique name for this machine
  deviceConfig.monitor = "monitor = eDP-1, 2880x1800@120, 0x0, 2, bitdepth, 10";
}
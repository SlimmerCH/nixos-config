{ lib, ... }: {
  options.deviceConfig = {
    monitor = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The Hyprland monitor string for this device.";
    };
  };
}

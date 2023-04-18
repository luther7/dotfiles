{ config, pkgs, ... }:
{
  imports =
    [
      <nixos-hardware/lenovo/thinkpad/t480>
      ./hardware-configuration.nix
    ];
  nixpkgs.config.allowUnfree = true;
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    initrd = {
      secrets = { "/crypto_keyfile.bin" = null; };
      luks.devices = {
        "luks-cdadc927-c5f2-4133-a223-0c21a15e8e9b".device = "/dev/disk/by-uuid/cdadc927-c5f2-4133-a223-0c21a15e8e9b";
        "luks-cdadc927-c5f2-4133-a223-0c21a15e8e9b".keyFile = "/crypto_keyfile.bin";
      };
    };
    kernelParams = [
      "i915.modeset=1"
      "i915.fastboot=1"
      "i915.enable_guc=2"
      "i915.enable_psr=0"
    ];
    kernelModules = [
      "acpi_call"
      "coretemp"
      "kvm-intel"
    ];
  };
  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    acpilight.enable = true;
    pulseaudio.enable = false;
    bluetooth.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        beignet
        intel-media-driver
        libvdpau-va-gl
        vaapiIntel
        vaapiVdpau
        blueman
      ];
    };
    trackpoint = {
      enable = true;
      sensitivity = 255;
      speed = 255;
    };
  };
  networking = {
    hostName = "green";
    networkmanager.enable = true;
    # useNetworkd = true;
    # wireless = {
    #   userControlled.enable = true;
    #   enable = true;
    #   interfaces = [ "wlp3s0" ];
    # };
    useDHCP = false;
    interfaces = {
      "enp0s31f6".useDHCP = true;
      "wlp3s0".useDHCP = true;
    };
  };
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
  location.provider = "geoclue2";
  sound.enable = true;
  security.rtkit.enable = true;
  time.timeZone = "Australia/Melbourne";
  i18n = {
    defaultLocale = "en_AU.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_AU.UTF-8";
      LC_IDENTIFICATION = "en_AU.UTF-8";
      LC_MEASUREMENT = "en_AU.UTF-8";
      LC_MONETARY = "en_AU.UTF-8";
      LC_NAME = "en_AU.UTF-8";
      LC_NUMERIC = "en_AU.UTF-8";
      LC_PAPER = "en_AU.UTF-8";
      LC_TELEPHONE = "en_AU.UTF-8";
      LC_TIME = "en_AU.UTF-8";
    };
  };
  environment = {
    systemPackages = with pkgs; [
      acpi
      cachix
      distrobox
      docker
      git
      glxinfo
      htop
      libinput
      libinput-gestures
      linuxPackages.acpi_call
      linuxPackages.cpupower
      linuxPackages.tp_smapi
      lm_sensors
      man-pages
      man-pages-posix
      microcodeIntel
      mullvad-vpn
      pciutils
      powertop
      throttled
      tlp
      vim
      virt-manager
      wget
    ];
    etc = {
      "sysconfig/lm_sensors".text = ''
        HWMON_MODULES="coretemp"
      '';
    };
  };
  programs = {
    dconf.enable = true;
    light.enable = true;
    # xwayland.enable = true;
  };
  services = {
    acpid.enable = true;
    blueman.enable = true;
    thermald.enable = true;
    fwupd.enable = true;
    printing.enable = true;
    power-profiles-daemon.enable = false;
    mullvad-vpn.enable = true;
    journald.extraConfig = "SystemMaxUse=500M";
    logind.killUserProcesses = true;
    xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
        autoLogin = {
          enable = true;
          user = "luther";
        };
      };
      desktopManager.gnome.enable = true;
      # displayManager.sddm.enable = true;
      # desktopManager.plasma5.enable = true;
      layout = "au";
      xkbVariant = "";
      libinput = {
        enable = true;
        mouse = {
          accelProfile = "flat";
          accelSpeed = "10";
        };
      };
      displayManager.sessionCommands = ''
        xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" 1
      '';
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
    gnome = {
      gnome-keyring.enable = true;
      core-shell.enable = true;
      core-os-services.enable = true;
      core-utilities.enable = false;
      core-developer-tools.enable = false;
      games.enable = false;
    };
    throttled = {
      enable = true;
      extraConfig = ''
        [GENERAL]
        # Enable or disable the script execution
        Enabled: True
        # SYSFS path for checking if the system is running on AC power
        Sysfs_Power_Path: /sys/class/power_supply/AC*/online
        # Auto reload config on changes
        Autoreload: True
        
        ## Settings to apply while connected to Battery power
        [BATTERY]
        # Update the registers every this many seconds
        Update_Rate_s: 30
        # Max package power for time window #1
        PL1_Tdp_W: 29
        # Time window #1 duration
        PL1_Duration_s: 28
        # Max package power for time window #2
        PL2_Tdp_W: 44
        # Time window #2 duration
        PL2_Duration_S: 0.002
        # Max allowed temperature before throttling
        Trip_Temp_C: 80
        # Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
        cTDP: 0
        # Disable BDPROCHOT (EXPERIMENTAL)
        Disable_BDPROCHOT: False
        
        ## Settings to apply while connected to AC power
        [AC]
        # Update the registers every this many seconds
        Update_Rate_s: 5
        # Max package power for time window #1
        PL1_Tdp_W: 44
        # Time window #1 duration
        PL1_Duration_s: 28
        # Max package power for time window #2
        PL2_Tdp_W: 44
        # Time window #2 duration
        PL2_Duration_S: 0.002
        # Max allowed temperature before throttling
        Trip_Temp_C: 80
        # Set HWP energy performance hints to 'performance' on high load (EXPERIMENTAL)
        # Uncomment only if you really want to use it
        # HWP_Mode: False
        # Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
        cTDP: 0
        # Disable BDPROCHOT (EXPERIMENTAL)
        Disable_BDPROCHOT: False
        
        [UNDERVOLT]
        # CPU core voltage offset (mV)
        CORE: -100
        # Integrated GPU voltage offset (mV)
        GPU: -100
        # CPU cache voltage offset (mV)
        CACHE: -105
        # System Agent voltage offset (mV)
        UNCORE: -85
        # Analog I/O voltage offset (mV)
        ANALOGIO: 0
        
        # Stable
        # [UNDERVOLT]
        # # CPU core voltage offset (mV)
        # CORE: -60
        # # Integrated GPU voltage offset (mV)
        # GPU: -85
        # # CPU cache voltage offset (mV)
        # CACHE: -105
        # # System Agent voltage offset (mV)
        # UNCORE: -85
        # # Analog I/O voltage offset (mV)
        # ANALOGIO: 0
      '';
    };
    tlp = {
      enable = true;
      settings = {
        PCIE_ASPM_ON_BAT = "powersupersave";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_MAX_PERF_ON_AC = "80";
        CPU_MAX_PERF_ON_BAT = "40";
        STOP_CHARGE_THRESH_BAT1=95;
        STOP_CHARGE_THRESH_BAT0=95;
      };
    };
  };
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };
  powerManagement = {
    # powertop.enable = true;
    # cpuFreqGovernor = "powersave";
    # cpufreq.min = 2500000;
    # powerManagement.resumeCommands = with pkgs; ''
    #   ${binPath xorg.xmodmap} -e 'keycode 117 = XF86Forward'
    #   ${binPath xorg.xmodmap} -e 'keycode 112 = XF86Back'
    # '';
  };
  users.users.luther = {
    isNormalUser = true;
    description = "Luther";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
  systemd.services.nix-gc.unitConfig.ConditionACPower = true;
  system.stateVersion = "22.11";
}

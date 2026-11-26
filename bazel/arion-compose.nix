let
  sshKeys = import ./ssh-keys.nix;
in
{
  project.name = "toktok";

  services.bazel =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      image.name = "ghcr.io/toktok/bazel";

      # Arion 0.2.2.0's nixos.useSystemd imports container-systemd.nix, which sets
      # the removed services.journald.console option on NixOS 26.11. Inline the same
      # systemd container setup with services.journald.settings.Journal instead.
      image.command = [ "/usr/sbin/init" ];
      image.contents = [
        (pkgs.runCommand "root-init" { } ''
          mkdir -p $out/usr/sbin
          ln -s ${config.nixos.build.toplevel}/init $out/usr/sbin/init
        '')
      ];
      service.environment.container = "docker";
      service.environment.PATH = "/usr/bin:/run/current-system/sw/bin/";
      service.volumes = [ "/sys/fs/cgroup:/sys/fs/cgroup:ro" ];
      service.tmpfs = [
        "/run"
        "/run/wrappers"
        "/tmp:exec,mode=777"
      ];
      service.stop_signal = "SIGRTMIN+3";
      service.tty = true;

      nixos = {
        configuration = {
          imports = [ (pkgs.path + "/nixos/modules/profiles/minimal.nix") ];

          boot.isContainer = true;
          boot.specialFileSystems = lib.mkForce { };
          boot.tmp.useTmpfs = true;
          nix.settings.sandbox = false;

          # Avoid /nix/store/.links: in Docker overlay2 it saves 1%.
          nix.settings.auto-optimise-store = false;

          services.journald.settings.Journal = {
            ForwardToConsole = true;
            TTYPath = "/dev/console";
          };
          services.openssh.enable = true;
          services.nscd.enable = false;

          system.stateVersion = "26.11";
          system.nssModules = lib.mkForce [ ];

          systemd.services.systemd-logind.enable = false;
          systemd.services.console-getty.enable = false;
          systemd.sockets.nix-daemon.enable = true;
          systemd.services.nix-daemon.enable = true;

          networking = {
            hostName = "";
            useDHCP = false;
            firewall.enable = false;
          };

          environment.systemPackages = [
            pkgs.bazel_9
            pkgs.bazel-remote
            pkgs.coreutils
            pkgs.git
            # Needed because coursier (for Kotlin) requires that java is in $PATH.
            pkgs.jdk21_headless
            pkgs.python3
          ];

          security.sudo.wheelNeedsPassword = false;

          programs.zsh.enable = true;
          users = {
            mutableUsers = false;

            users = {
              root.openssh.authorizedKeys.keys = sshKeys.builder;

              builder = {
                uid = 1000;
                isNormalUser = true;
                shell = pkgs.zsh;
                home = "/home/builder";
                description = "TokTok Builder User";
                extraGroups = [ "wheel" ];
                openssh.authorizedKeys.keys = sshKeys.builder;
              };
            };
          };
        };
      };

      service.useHostStore = false;
      service.ports = [
        "2345:22" # host:container
      ];
    };
}

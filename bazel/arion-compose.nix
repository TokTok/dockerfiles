let
  sshKeys = import ./ssh-keys.nix;
in
{
  project.name = "toktok";

  services.bazel =
    { pkgs, lib, ... }:
    {
      image.name = "toxchat/bazel";

      nixos = {
        useSystemd = true;
        configuration = {
          boot.tmp.useTmpfs = true;
          nix.settings.sandbox = false;
          nix.settings.auto-optimise-store = true;

          services.openssh.enable = true;
          services.nscd.enable = false;

          system.stateVersion = "24.11";
          system.nssModules = lib.mkForce [ ];

          systemd.sockets.nix-daemon.enable = true;
          systemd.services.nix-daemon.enable = true;

          environment.systemPackages = [
            pkgs.bazel_6
            pkgs.coreutils
            pkgs.git
            # Needed because coursier (for Kotlin) requires that java is in $PATH.
            pkgs.jdk17_headless
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

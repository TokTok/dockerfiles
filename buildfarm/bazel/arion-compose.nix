let
  sshKeys = import ./ssh-keys.nix;
in {
  project.name = "toktok";

  services.bazel = { pkgs, lib, ... }: {
    image.name = "toxchat/bazel";

    nixos = {
      useSystemd = true;
      configuration = {
        boot.tmp.useTmpfs = true;
        nix.settings.sandbox = false;

        services.openssh.enable = true;
        services.nscd.enable = false;

        system.stateVersion = "23.05";
        system.nssModules = lib.mkForce [];

        systemd.sockets.nix-daemon.enable = true;
        systemd.services.nix-daemon.enable = true;

        environment.systemPackages = [
          pkgs.bazel
          pkgs.coreutils
          pkgs.git
        ];

        security.sudo.wheelNeedsPassword = false;

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
      "2345:22"  # host:container
    ];
  };
}

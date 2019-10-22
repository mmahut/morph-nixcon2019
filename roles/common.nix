{config, pkgs, ...}:
{

  # general network settings
  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [
    22 # ssh
    9100 # prometheus exporter
  ];

  # warning for all users
  users.motd = ''

** ** ** ** ** ** ** ** ** ** ** ** ** **
 This system is under Morph' management!
   All your local changes will be lost.
** ** ** ** ** ** ** ** ** ** ** ** ** **

  '';

  nix.nixPath =
  let
    morph-rebuild-throw = pkgs.writeText "morph-rebuild-throw.nix"
      ''throw "Please deploy this host with morph."'';
  in
    [ "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos:nixos-config=${morph-rebuild-throw}:/nix/var/nix/profiles/per-user/root/channels" ];


  # packages relevant for all systems
  environment.systemPackages = with pkgs; [
    htop
    screen
    vim
    wget
    unzip
   ];

  services.cron.enable = true;
  services.cron.mailto = "it@satoshilabs.com";

  # Auto optimaze the nix store
  nix.autoOptimiseStore = true;
}

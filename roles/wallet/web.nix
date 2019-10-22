{config, pkgs, ...}:
{
  # Firewall settings
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # Custom packages
  environment.systemPackages = with pkgs; [ mdbook ];

  # Nginx settings
  services.nginx.enable = true;
  services.nginx.virtualHosts."web1.wallet.prod.hq.sldev.cz" = {
    serverAliases = [ "wallet.trezor.io" ];
    root = "/var/www/wallet";
    extraConfig = ''
      rewrite ^/$ /trezor-firmware/core/ redirect;
      '';
  };

  deployment = {
    healthChecks = {
      http = [
        {
          scheme = "http";
          port = 80;
          host = "wallet.trezor.io";
          path = "/trezor-firmware/core";
          description = "Checking trezor-firmware/core status page";
        }
      ];
    };
  };
}

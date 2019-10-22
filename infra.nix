let
  # Pin the deployment package-set to a specific version of nixpkgs
  # nix-prefetch-url --unpack "https://github.com/NixOS/nixpkgs-channels/archive/<rev>.tar.gz"
  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/e19054ab3cd5b7cc9a01d0efc71c8fe310541065.tar.gz";
    sha256 = "0b92yhkj3pq58svyrx7jp0njhaykwr29079izqn6qs638v8zvhl2";
  }) {};
in
{
  network =  {
    inherit pkgs;
    description = "Morph example for NixCon2019";
  };

  "db1.wallet.prod.hq.sldev.cz" = { config, pkgs, ... }: {
    imports = [ profiles/db1.wallet.prod.hq.sldev.cz.nix ];
  };

  "web1.wallet.prod.hq.sldev.cz" = { config, pkgs, ... }: {
    imports = [ profiles/web1.wallet.prod.hq.sldev.cz.nix ];
  };

}

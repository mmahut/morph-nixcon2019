## this file contains profile of a host
{ config, pkgs, ... }:
{
    ## host specific variables
    networking.hostName = "web1.wallet.prod.do.sldev.cz";

    ### Imports
    imports = [

    ## hardware and boot configuration
    ../hardware/ovirt.nix

    ## server specific roles
    ../roles/common.nix
    ../roles/wallet/web.nix

    ];
}


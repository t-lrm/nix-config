{
    pkgs,
        lib,
        username,
        host,
        ...
}: {

# Server identity
    networking.hostName = "nixos-server";
    networking.useDHCP = true;

# SSH access
    services.openssh = {
        enable = true;
        openFirewall = true;
        settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
            PermitRootLogin = "no";
        };
    };

# Administrator account
    users.users.admin = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAA... your-public-key"
        ];
    };

# Bootloader (UEFI systems)
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;


    programs.zsh.enable = true;

    users.users.admin.shell = pkgs.zsh;

# Optional useful tools
    environment.systemPackages = with pkgs; [
        vim
            git
            htop
            curl
            zsh
            fzf
            eza
            ripgrep
            bat
    ];

}


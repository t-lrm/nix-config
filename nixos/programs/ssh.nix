{
  config,
  pkgs,
  ...
}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    # 1Password SSH agent
    matchBlocks."*" = {
      identityAgent = "~/.1password/agent.sock";
    };
  };
}

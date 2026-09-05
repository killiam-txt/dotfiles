{inputs, ...}: {
  programs.nixvim = {
    enable = true;
    nixpkgs.source = inputs.nixpkgs;
    version.enableNixpkgsReleaseCheck = false;

    imports = [
      # plugins
      ./plugins/basics.nix
      ./plugins/completion.nix
      ./plugins/extra.nix
      ./plugins/files.nix
      ./plugins/git.nix
      ./plugins/icons.nix
      ./plugins/notify.nix
      ./plugins/pairs.nix
      ./plugins/statusline.nix
      ./plugins/starter.nix
      ./plugins/snippets.nix
      ./plugins/which-key.nix
      ./plugins/conform.nix
      ./plugins/treesitter.nix
      ./plugins/term.nix

      # lsp
      ./lsp/default.nix

      # keymaps
      ./keymaps.nix

      # options
      ./options.nix
    ];
  };
}

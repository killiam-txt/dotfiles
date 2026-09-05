{pkgs, ...}: {
  opts = {
    number = true;
    relativenumber = false;
    colorcolumn = "0";
    shiftwidth = 2;
    tabstop = 2;
    wrap = false;
    swapfile = false; # undotree
    backup = false; # undotree
    undofile = true;
    hlsearch = false;
    incsearch = true;
    termguicolors = true;
    scrolloff = 8;
    signcolumn = "no";
    updatetime = 50;
    foldlevelstart = 99;
  };

  clipboard = {
    register = "unnamedplus";
  };

  globals.mapleader = " ";

  extraPackages = with pkgs; [
    rust-analyzer
    pyright
    ruff
    stylua
    nixfmt
  ];

  extraPlugins = with pkgs; [
    vimPlugins.vim-crystal
    vimPlugins.neocord
    vimPlugins.koda-nvim
    # vimPlugins.***-nvim  # alternative
  ];

  extraConfigLua = builtins.readFile ./config.lua;
}

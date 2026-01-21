{...}: {
  programs.vim = {
    enable = true;
    defaultEditor = true;

    extraConfig = ''
      filetype plugin indent on
      syntax on

      set number
      set laststatus=2
      set wrap
      set linebreak
      set scrolloff=10
      set sidescrolloff=10

      set incsearch
      set hlsearch

      " Search is case-sensitive only if it
      " contains a capital letter
      set ignorecase
      set smartcase

      set expandtab
      set tabstop=4
      set shiftwidth=4
      set softtabstop=4
      set smartindent
      set autoindent
    '';
  };
}

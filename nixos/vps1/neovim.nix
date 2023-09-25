{
  nixvim = {
    enable = true;
    clipboard.providers.wl-copy.enable = true; # Enable the wayland clipboard
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
    };
    maps = {
      normal."<space>ee" = {
	silent = true;
	action = "<cmd>lua vim.diagnostic.open_float()<CR>"; # Expands the LSP error message (useful when the message is longer than a line, because the LSP doesn't have line wrap
      };
    };
    plugins = {
      rainbow-delimiters.enable = true; # This gives every parenthesis a different color
      treesitter.enable = true; # Fancy Syntax highlighting plugin
      cmp-dictionary.enable = true;
      cmp-nvim-lsp.enable = true;
      comment-nvim.enable = true; # Provides easy keybindings to comment a line or multiple lines
      airline.enable = true; # Fancy statusbar
      todo-comments.enable = true; # Shows the TODO comments in a colorful way
      coq-nvim = {
	enable = true; # Autocompletion display
	autoStart = true;
      };
      harpoon = {
	enable = true;
	keymaps = {
	  navNext = "<Space>s<CR>";
	  navPrev= "<Space>a<CR>";
	  addFile = "<Space>ha<CR>";
	};
      };
      lsp = {
        enable = true;
	servers = {
	  gopls.enable = true; # Golang LSP
	  rust-analyzer.enable = true; # Rust LSP
	  nil_ls.enable = true; # Nix LSP
	  jsonls.enable = true; # JSON LSP
	  yamlls.enable = true; # YAML LSP
	  pylsp.enable = true; # Python LSP
	  html.enable = true; # HTML LSP
	  cssls.enable = true; # CSS LSP
	  svelte.enable = true; # Svelte LSP
	  tailwindcss.enable = true; # Tailwind LSP
	};
      };
      telescope = {
	enable = true;
	keymaps = {
	  "<space>gf" = {
	    action = "git_files";
	    desc = "Telescope git files";
	  };
	  "<space>ff" = {
	    action = "find_files";
	    desc = "Telescope files generally";
	  };
	};
      };
    };
    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };
  };
}

{
  flake.nixvim.keymaps = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      # move highlighted lines with J and K in visual mode
      {
        key = "J";
        mode = "v";
        action = ":m '>+1<CR>gv=gv";
      }
      {
        key = "K";
        mode = "v";
        action = ":m '<-2<CR>gv=gv";
      }
      # stay in visual mode after indenting
      {
        key = "<";
        mode = "v";
        action = "<gv";
      }
      {
        key = ">";
        mode = "v";
        action = ">gv";
      }
      # keep cursor in the center
      {
        key = "<c-d>";
        mode = "n";
        action = "<c-d>zz";
      }
      {
        key = "<c-u>";
        mode = "n";
        action = "<c-u>zz";
      }
      {
        key = "n";
        mode = "n";
        action = "nzzzv";
      }
      {
        key = "N";
        mode = "n";
        action = "Nzzzv";
      }
      # <pageup>/<pagedown> should function as c-u and c-d
      {
        key = "<pagedown>";
        mode = "n";
        action = "<c-d>zz";
      }
      {
        key = "<pageup>";
        mode = "n";
        action = "<c-u>zz";
      }
      {
        key = "<esc>";
        mode = "n";
        action = "<cmd>nohlsearch<cr>";
      }
      # yank file names
      {
        key = "<leader>yfn";
        mode = "n";
        action = ":lua vim.fn.setreg('+', vim.fn.expand('%:t'))<cr>";
      }
      {
        key = "<leader>yfr";
        mode = "n";
        action = ":lua vim.fn.setreg('+', vim.fn.expand('%:.'))<cr>";
      }
      {
        key = "<leader>yfa";
        mode = "n";
        action = ":lua vim.fn.setreg('+', vim.fn.expand('%:p'))<cr>";
      }
      {
        key = "<leader>e.";
        mode = "n";
        action = "<cmd>e %:h<cr>";
      }
      # search within visual selection
      {
        key = "/";
        mode = "v";
        action = "<Esc>/\\%V";
      }
      {
        key = "<c-]>";
        mode = "t";
        action = "<c-\\><c-n>";
      }
      # dont move cursor when joining lines
      # {
      #   key = "J";
      #   mode = "n";
      #   action = "mzJ'z";
      # }
    ];
  };
}

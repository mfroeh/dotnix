{ ... }:
{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = ",";
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
      # dont move cursor when joining lines
      # {
      #   key = "J";
      #   mode = "n";
      #   action = "mzJ'z";
      # }
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
      # resize font in neovide
      {
        key = "<C-+>";
        mode = "n";
        action = ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>";
      }
      {
        key = "<C-=>";
        mode = "n";
        action = ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>";
      }
      {
        key = "<C-->";
        mode = [
          "n"
          "v"
        ];
        action = ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>";
      }
      {
        key = "<C-0>";
        mode = [
          "n"
          "v"
        ];
        action = ":lua vim.g.neovide_scale_factor = 1<CR>";
      }
      {
        key = "<esc>";
        mode = "n";
        action = "<cmd>nohlsearch<cr>";
      }
    ];
  };
}

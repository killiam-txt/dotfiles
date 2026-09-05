{
  keymaps = [
    {
      key = "<Leader>e";
      action.__raw = ''
        function()
          require("neo-tree.command").execute({
            toggle = true,
            dir = vim.fn.getcwd()
          })
        end
      '';
    }
    {
      key = "<leader>ff";
      mode = ["n"];
      action = "<cmd>lua Snacks.picker.files()<CR>";
      options.desc = "find files";
    }
    {
      key = "<leader>gr";
      mode = ["n"];
      action = "<cmd>lua Snacks.picker.grep()<CR>";
      options.desc = "find grep";
    }
    {
      key = "<leader>gl";
      mode = ["n"];
      action = "<cmd>lua Snacks.picker.git_log()<CR>";
      options.desc = "git log";
    }
    {
      key = "<leader>gs";
      mode = ["n"];
      action = "<cmd>lua Snacks.picker.git_status()<CR>";
      options.desc = "git status";
    }
    {
      key = "<leader>uC";
      mode = ["n"];
      action = "<cmd>lua Snacks.picker.colorschemes()<CR>";
      options.desc = "colorschemes";
    }
    {
      key = "<leader>:";
      mode = ["n"];
      action = "<cmd>lua Snacks.picker.command_history()<CR>";
      options.desc = "command history";
    }
    {
      key = "<C-h>";
      mode = ["n"];
      action = "<cmd>Neotree source=filesystem focus<CR>";
      options.desc = "switch focus";
    }
  ];
}

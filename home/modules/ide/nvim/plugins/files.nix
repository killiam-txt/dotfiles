{
  plugins.snacks = {
    enable = true;
    autoLoad = true;
  };
  plugins.neo-tree = {
    enable = true;
    settings = {
      sources = [
        "filesystem"
        "buffers"
        "git_status"
      ];
      open_files_do_not_replace_types = [
        "terminal"
        "Trouble"
        "trouble"
        "qf"
        "Outline"
      ];
      open_files_in_last_window = true;
      enable_refresh_on_write = true;
      enable_modified_markers = true;
      enable_git_status = true;
      enable_diagnostics = true;
      default_component_configs = {
        indent = {
          with_expanders = true;
          expander_collapsed = "";
          expander_expanded = "";
          expander_highlight = "NeoTreeExpander";
        };
      };
      filesystem = {
        bind_to_cwd = false;
        follow_current_file.enabled = true;
        use_libuv_file_watcher = true;
      };
      event_handlers = [
        {
          event = "file_moved";
          handler.__raw = ''
            function(data)
              require("snacks.rename").on_rename_file(data.source, data.destination)
            end
          '';
        }
        {
          event = "file_renamed";
          handler.__raw = ''
            function(data)
              require("snacks.rename").on_rename_file(data.source, data.destination)
            end
          '';
        }
      ];
    };
  };
}
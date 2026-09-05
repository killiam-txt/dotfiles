# setup direnv
direnv hook fish | source

# set aliases
source ~/.config/fish/aliases/git.fish

# path
# fish_add_path -g ~/bin ~/go/bin ~/.config/v-analyzer/bin  # may use these later

# custom
function vir
    set dest (command vir $argv)
    and cd $dest
end

# prompt functions
function git_branch
    set -l branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if test $status -eq 0
        echo ' ( '$branch')'
    else
        echo ""
    end
end

function nix_shell
    if test -n "$IN_NIX_SHELL"
        echo " (nix)"
    else
        echo ""
    end
end

starship init fish | source
fastfetch
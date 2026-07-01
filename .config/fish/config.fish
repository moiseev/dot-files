if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx EDITOR vim
end

# Using a global variable so that $HOME is expanded
set -g --prepend fish_user_paths $HOME/bin $HOME/.cargo/bin $HOME/.ghcup/bin $HOME/.cabal/bin $HOME/.local/bin

set -gx RIPGREP_CONFIG_PATH $HOME/.ripgreprc

zoxide init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx EDITOR vim
end

set -gx HOMEBREW_GITHUB_API_TOKEN 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

# Using a global variable so that $HOME is expanded
set -g --prepend fish_user_paths $HOME/bin $HOME/.cargo/bin $HOME/.ghcup/bin

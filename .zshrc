# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bureau"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx brew cabal)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH="$HOME/.local/bin:$HOME/Library/Haskell/bin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
# for fsharpc compiled programs
export MONO_GAC_PREFIX="/usr/local"

export GOPATH=$HOME/Work/goplace
export PATH=$GOPATH/bin:$HOME/bin:$PATH
export NNTPSERVER=gmane.org

export EDITOR=vim
export VISUAL=vim
NNTPSERVER=snews://news.gmane.org

if [ "$TERM" \=\= "xterm" ]; then
    export TERM=xterm-256color
fi

autoload -Uz promptinit

#alias g=git
alias r3=rebar3

promptinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

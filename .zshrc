# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle :compinstall filename '/home/user/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100
SAVEHIST=100
setopt autocd
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

export LANG='pt_BR.UTF-8'
export EDITOR='nvim'

alias ls='ls --color=auto'
alias niri-session='dbus-run-session niri'

# https://git-scm.com/book/en/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Zsh
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
zstyle ':vcs_info:*' formats '%F{blue}(%b%u%c)%f '

PROMPT='%F{green}%n@%m%f:%F{yellow}%~%f ${vcs_info_msg_0_}'

(cat ~/.cache/wal/sequences &)

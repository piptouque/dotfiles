[ -z "$PS1" ] && return

# Run tmux if found
# from: https://unix.stackexchange.com/a/113768
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux
fi

shopt -s histappend                            # Add history from all the terminal opened
shopt -s checkwinsize                          # Keep checking terminal size
if [ $BASH_VERSINFO -ge 4 ]; then
  shopt -s globstar                            # ** enabled
  shopt -s autocd                              # Type the directory name and cd it
fi
set -o vi                                      # VI mode readline
stty -ixon                                     # Set forward searching

# File loading (Order matters) :ARCANE:
for file in `cat <&15`; do
  [ -f ~/.bash_${file} ] && . ~/.bash_${file}
done 15<<< "exports aliases prompt functions completion local"

# Git configuration
if [[ -z "$(git config --get user.name)" || -z "$(git config --get user.email)" ]]; then
  git config -f ~/.gitconfig.local user.name "$GIT_AUTHOR_NAME"
  git config -f ~/.gitconfig.local user.email "$GIT_AUTHOR_EMAIL"
fi

# additions to $PATH
for file in `cat <&15`; do
    [ -f "$HOME/.bash_${file}" ] && . "$HOME/.bash_${file}"
  done 15<<< "exports exports.local"

[ -z "$PS1" ] && return

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
  [ -f "$HOME/.bash_${file}" ] && . "$HOME/.bash_${file}"
done 15<<< "aliases prompt functions completion local"


# Git configuration
if [[ -z "$(git config --get user.name)" || -z "$(git config --get user.email)" ]]; then
  git config -f ~/.gitconfig.local user.name "$GIT_AUTHOR_NAME"
  git config -f ~/.gitconfig.local user.email "$GIT_AUTHOR_EMAIL"
fi

# Run tmux if found
# Run after files so that it gets the environment variables defined above
# from: https://unix.stackexchange.com/a/113768
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux
fi


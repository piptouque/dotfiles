# .bash_profile

# additions to $PATH
for file in `cat <&15`; do
    [ -f "$HOME/.bash_${file}" ] && . "$HOME/.bash_${file}"
  done 15<<< "exports exports_local"

# Get the aliases and functions
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

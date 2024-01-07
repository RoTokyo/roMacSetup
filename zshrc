# ********** History file settings
HISTFILE='$HOME/.zsh_history'
HISTSIZE=2000
SAVEHIST=$HISTSIZE
# export HISTFILESIZE="${HISTSIZE}";
# export HISTCONTROL='ignoreboth';
# HISTORY_IGNORE='l|l *|ls|ls *|cd|cd ..*|cd -|z *|pwd|exit|reload|'
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt extendedglob

# ********** .zprofile
source .zprofile

# ********** Caricamento Impostazioni da bash
for file in ~/.{bash_prompt,bash_aliases}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done
unset file

# ******************************
# Load Config Files
#*******************************

#******* Path ******************
# export PATH="/usr/local/opt/curl/bin:$PATH"
# export PATH="/usr/local/bin:$PATH"
#
#******* PATH added by Homebrew
export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
export PATH="/usr/local/opt/sphinx-doc/bin:$PATH"

# ****** Dot files *************
for file in ~/.{bash_prompt,bash_exports,bash_aliases,bash_functions,bash_extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done
unset file

# ******************************
# Load Config Files
#*******************************

#******* Path ******************
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# ****** Dot files *************
for file in ~/.{bash_prompt,bash_aliases,bash_export,bash_functions}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done
unset file

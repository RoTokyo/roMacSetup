# ******************************
# Load Config Files
#*******************************

#******* Path ******************
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"

export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"

# ****** Dot files *************
for file in ~/.{bash_prompt,bash_aliases,bash_export,bash_functions}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done
unset file


export NVM_DIR="/Users/rc/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# ********** rBenv & Ruby
eval "$(rbenv init - zsh)"

# ********** NVM
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"

# ********** Brew
eval "$(/usr/local/bin/brew shellenv)"
export HOMEBREW_NO_AUTO_UPDATE=1

# ********** Mac Port
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# ********** NOTE
#  inetutils has the following notes:
#    All clients are now installed with the "g" prefix. This means that you'll now, for example, find GNU telnet at
#    /opt/local/bin/gtelnet. If you dislike typing gtelnet, you can create a shell alias or you can add
#    /opt/local/libexec/gnubin to your PATH, wherein non-g* prefixed symlinks are installed. In other words,
#    /opt/local/libexec/gnubin contains GNU binaries without any prefix to the file names, so you can type telnet and
#    get GNU telnet just as before. The (g)whois client has been removed as it duplicates the separate whois port
export PATH="/opt/local/libexec/gnubin:$PATH"

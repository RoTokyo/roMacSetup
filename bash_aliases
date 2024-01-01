# ********** Alias in uso
alias ..='cd ..'
alias ls='ls -lah'
alias cls='clear'
alias flush='dscacheutil -flushcache; sudo killall -HUP mDNSResponder'                    # Flush dns cache
alias reload='cls; source ~/.zshrc'               # Update bash profile
alias dsclean='find . -type f -name .DS_Store -delete'   # Get rid of .DS_Store files recursively
alias hosts='sudo nano /etc/hosts'

# alias ss='sudo /usr/sbin/apachectl start'                          # Start server
# alias qs='sudo /usr/sbin/apachectl graceful-stop'                  # Stop server
# alias rs='sudo /usr/sbin/apachectl restart'                        # Restart server

alias ss='brew services start httpd'
alias qs='brew services stop httpd'
alias rs='brew services restart httpd'

alias errlog='tail -f /usr/local/var/log/httpd/error_log'            # Monitor Web Server Error
alias check='sudo lsof -i:80'                                        # Check if httpd is running


alias show='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hide='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'


alias mta='f() {exiftool -a -s -H -G1 -sort "$@"; unset -f f; }; f'
alias mt='f() {exiftool -sort "$@"; unset -f f; }; f'

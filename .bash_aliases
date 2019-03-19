#*******************************
# Aliases
# ******************************

# ****** Navigation Commands ***
alias m='cd /Users/rc/Projects'
alias k='cd /Users/rc/Projects/roTokyo'
alias j='cd /Users/rc/Projects/roMacSetup'

# ****** jekyll Commands *********
alias jx='bundle exec jekyll clean; rm -rf .sass-cache'
alias jb='JEKYLL_ENV=production bundle exec jekyll build'
alias js='JEKYLL_ENV=development bundle exec jekyll serve --incremental'
alias jp='JEKYLL_ENV=production  bundle exec jekyll serve'
alias wd='$HOME/bin/zz-write-draft.sh'
alias up='jb && cd ~/bin && ./zz-rsync_dest_to_server.sh && cd ~/Sites && gitacom "Web upload" && gitpom'

# ****** System ****************
alias show='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hide='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias flush='dscacheutil -flushcache'                    # Flush dns cache
alias dsclean='find . -type f -name .DS_Store -delete'   # Get rid of .DS_Store files recursively

alias mbp='vim ~/.bash_aliases'                          # Read & modify bash aliases
alias reload='cls; source ~/.bash_profile'               # Update bash profile

alias cls='clear'
alias ss='sudo apachectl start'                          # Start server
alias qs='sudo apachectl graceful-stop'                  # Stop server

# ****** Git *******************
alias giti='git init'
alias gits='git status && git pull'
alias gita='git add -A && git status'
alias gitcom='git commit -am'
alias gitacom='git add -A && git commit -am'
alias gitpop='git push -u origin gh-pages'
alias gitpom='git push -u origin master'
alias gitlog='git log --pretty=oneline'

# ****** npm Commands **********
alias nl='npm ls --depth=0'

# ****** Useful Commands *******
alias la='ls -AF'                                        # Compact view, show hidden
alias ll='ls -al'
alias l='ls -a'
alias l1='ls -1'
alias cls='clear'

alias ..='cd ..'                                         # Go up one directory
alias ...='cd ../..'
alias ....='cd ../../..'

alias h='history'

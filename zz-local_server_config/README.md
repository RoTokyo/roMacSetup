# My local testing server setup files

**NB:** Backup original files before modifying!

**File location:**

1. `/etc/apache2/users/`
2. `/etc/apache2/httpd.conf`
3. `/etc/apache2/extra/httpd-vhosts.conf`
4. `/etc/hosts`

**Commands:**

1. `sudo apachectl start`
2. `sudo apachectl stop`
3. `sudo apachectl restart`
4. Apache version `httpd -v`
5. To check server status on browser `http://localhost/server-status`  

**Web Development Environment**

Install `dnsmasq` with HomeBrew and configure it as follow:  

1. `brew install dnsmasq`  
2. `cd $(brew --prefix); mkdir etc; echo 'address=/.test/127.0.0.1' > etc/dnsmasq.conf`  
3. `sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons`  
4. `sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist`
5. `sudo mkdir /etc/resolver`  
6. `sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'`  

Then go to [apple] > [System Preferences] > [Security e Privacy] > [Firewall] and allow the service `httpd` to accept incoming call.  

In [Apple] > [Network] read your machine IP

Then configure `/etc/apache2/extra/httpd-vhosts.conf` as shown in inside example!

Many thanks to: [Chris Mallison](https://mallinson.ca/posts/5/the-perfect-web-development-environment-for-your-new-mac) for the ideas!

## Use it yourself

**Important:**  *I am a novice programmer.*  **USE AT YOUR OWN RISK**



## Credits

Inspiration [Neil Gee](https://coolestguidesontheplanet.com/get-apache-mysql-php-phpmyadmin-working-osx-10-9-mavericks/)

### Licence

© MIT
#!/usr/bin/env bash

brew uninstall node
brew prune
rm -f /usr/local/bin/npm /usr/local/lib/dtrace/node.d
rm -rf ~/.npm
rm -rf /usr/local/lib/node_modules
#!/usr/bin/env zsh
echo "==== generating a new ssh key"
mkdir -p ~/.ssh
ssh-keygen -t rsa -b 4096 -C "m.d.smart@gmail.com"
eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | pbcopy
open "https://github.com/settings/keys"
echo "New ssh key is in clipboard add it to github"

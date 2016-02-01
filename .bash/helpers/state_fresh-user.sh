#!/bin/sh
# used for bash prompt
# by 'user-at-host-prompt.sh':
# $CONFIGURED_USER
# $CONFIGURED_HOST

HOST=$(hostname -fs)
proxycmd=$"#!/bin/bash\nexport CONFIGURED_USER=$USER\nexport CONFIGURED_HOST=$HOST\n#generated from .dotfiles 'fresh-user.sh'"
echo "$proxycmd" > ~/.bash/state/.fresh-user

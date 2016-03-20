#!/bin/zsh

# Saved in ~/online-check.sh and in a cron job as:
# * * * * * ~/online-check.sh

# An online indicator, green for active connection, and red for not.
# It's done by a cronjob touching or removing a file to indicate
# status every minute, and the file is checked by the prompt.

local offline=`dig 8.8.8.8 +time=1 +short google.com A | grep -c "no servers could be reached"`
if [[ "$offline" == "0" ]]; then
  rm ~/.offline
else
  touch ~/.offline
fi

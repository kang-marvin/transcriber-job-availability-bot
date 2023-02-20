#!/bin/bash

# Delete all crontab
crontab -r

echo "
  ** All cron jobs have been removed **

  If you wish to start the bot again, do:
    - make changes to config/schedule.rb file
    - run this start script
"


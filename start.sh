#!/bin/bash

# Start the cronjob
whenever --update-crontab

echo "
  ** The bot has started **

  It will run every [SCHEDULED_DURATION] set on config/schedule.rb

  If you wish to change anything like the audio played or adjust the duration, do:
    - run the stop script
    - make the relevant changes
    - run this start script
"


#! /bin/bash

#runTimer=true
#while [ "$runTimer" = true ] ; do
    osascript -e 'display notification "Starting work timer.\nWork for the next 25 minutes" with title "Pomodoro"'
    sleep 1500 # Sleep 25 minutes
    osascript -e 'display notification "Take a break" with title "Pomodoro"'
    sleep 240 # Sleep 4 minutes
    osascript -e 'display notification "Break ends in 1 minute" with title "Pomodoro"'
    sleep 60
    #osascript -e 'tell app "System Events" to display dialog "Time to get back to work. Would you like to restart the timer?"'
    osascript -e 'display notification "Beak over.\nRestart script to continue timer." with title "Pomodoro"'
#done

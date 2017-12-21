#! /bin/bash

#runTimer=true
#while [ "$runTimer" = true ] ; do
    osascript -e 'display notification "Starting work timer.\nWork for the next 25 minutes" with title "Pomodoro"'
    say "Begin."
    sleep 1500 # Sleep 25 minutes
    # Timing with progress bar (Not yet working)
    #for i in `25` ; do
    #    echo -ne "\r|"            # Return to start of line
    #    for j in `$i` ; do      # Progress
    #        echo -ne "#"
    #    done
    #    for k in `25-$i` ; do   # Pad with spaces
    #        echo -ne " "
    #    done
    #    echo -ne "| $k/25"         # minutes completed as number
    #    sleep 1               # Wait for one minute
    #done
    echo -ne "\n"
    osascript -e 'display notification "Take a break" with title "Pomodoro"'
    say "Time to take a break."
    sleep 240 # Sleep 4 minutes
    osascript -e 'display notification "Break ends in 1 minute" with title "Pomodoro"'
    say "One minute warning."
    sleep 60
    #osascript -e 'tell app "System Events" to display dialog "Time to get back to work. Would you like to restart the timer?"'
    osascript -e 'display notification "Beak over.\nRestart script to continue timer." with title "Pomodoro"'
    say "Break period over."
#done

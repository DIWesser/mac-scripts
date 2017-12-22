#! /bin/bash

# Basic Technique (https://en.wikipedia.org/wiki/Pomodoro_Technique)

# 1. Decide on the task to be done.
# 2. Set the pomodoro timer (traditionally to 25 minutes).
# 3. Work on the task.
# 4. End work when the timer rings and put a checkmark on a piece of paper.
# 5. If you have fewer than four checkmarks, take a short break (3–5 minutes),
#    then go to step 2.
# 6. After four pomodoros, take a longer break (15–30 minutes), reset your
#    checkmark count to zero, then go to step 1.

settings=$HOME/.config/my-scripts/pomodoro.conf

# Use grep to find line for variable. Extracts everything between first and second ':'
# Trims whitspace from both ends.
# Regex matches start of line excluding whitespace.
# Times are returned in seconds
shortBreak=$(grep -iw '^\s*short break:' $settings | cut -d: -f2 | xargs)
longBreak=$(grep -i '^\s*long break:' $settings | cut -d: -f2 | xargs)
workPeriod=$(grep -i '^\s*work period:' $settings | cut -d: -f2 | xargs)

#runTimer=true
#while [ "$runTimer" = true ] ; do
    osascript -e 'display notification "Starting work timer.\nWork for 25 minutes" with title "Pomodoro"'
    say "Begin."
    sleep $workPeriod # Sleep 25 minutes
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

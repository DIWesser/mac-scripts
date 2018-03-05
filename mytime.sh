if [ -f $HOME/.config/my-scripts/device-id ] ; then
    settings="$HOME/.config/my-scripts/device-id"
    myTimezone=$(grep -iw '^\s*timezone:' $settings | cut -d: -f2 | xargs)
    env TZ=$myTimezone date +"%H:%M %Z"
else
    date +"%H:%M %Z"
fi



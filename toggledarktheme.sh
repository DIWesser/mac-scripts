#!/bin/bash
# In theory this should set toggle the GTK theme between Adwaita and
# Adwaita-dark.
# If an unrecognized theme is in use, the theme is changed to Adwaita-dark.

new_theme="Adwaita-dark"
current_theme="$(gsettings get org.gnome.desktop.interface gtk-theme |
                 sed "s/^'//; s/'\$//")" # Remove single quotes
echo "Current theme is $current_theme"

if [ $current_theme = "Adwaita-dark" ]; then
    new_theme="Adwaita"
    echo "Changing theme to $new_theme"
else
    echo "Changing theme to $new_theme"
fi

gsettings set org.gnome.desktop.interface gtk-theme "$new_theme"
gsettings set org.gnome.desktop.wm.preferences theme "$new_theme"

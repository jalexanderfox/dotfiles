#!/bin/sh

# Change working directory
cd /Users/Shared/Junos/

# Install Junos Pulse software
/usr/sbin/installer -pkg JunosPulse.mpkg -target /
sleep 1

/bin/chmod +x /Applications/Junos\ Pulse.app/Contents/Plugins/JamUI/PulseTray.app/Contents/MacOS/PulseTray
/bin/chmod +x /Applications/Junos\ Pulse.app/Contents/MacOS/Junos\ Pulse
/bin/chmod +x /Applications/Junos\ Pulse.app/Contents/Plugins/JamUI/jamCommand

# Launch the Pulse Tray
/usr/bin/open -a '/Applications/Junos Pulse.app/Contents/Plugins/JamUI/PulseTray.app/Contents/MacOS/PulseTray'
sleep 1

# Open Junos Pulse in the background and then hide the app
/usr/bin/open --background -a '/Applications/Junos Pulse.app/Contents/MacOS/Junos Pulse'
/usr/bin/osascript -e 'tell application "System Events" to set visible of application process "Junos Pulse" to false'
sleep 1

# Import the company VPN settings
/Applications/Junos\ Pulse.app/Contents/Plugins/JamUI/jamCommand -importFile Company_VPN_Servers.jnprpreconfig
sleep 1

# Quit  the Junos Pulse app
/usr/bin/osascript -e 'tell application "Junos Pulse" to quit'
sleep 2

# Open Junos Pulse in the background a second time and then hide the app
/usr/bin/open --background -a '/Applications/Junos Pulse.app/Contents/MacOS/Junos Pulse'
/usr/bin/osascript -e 'tell application "System Events" to set visible of application process "Junos Pulse" to false'
sleep 5

# Quit  the Junos Pulse app
/usr/bin/osascript -e 'tell application "Junos Pulse" to quit'

exit 0

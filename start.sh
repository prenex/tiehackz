#!/bin/bash
# A little script that sets up proper display mode on my machine
# and uses the dosbox config to run TIE properly.
# This mentioned dosbox config also starts up my tiehackz.com control enchancer...

#echo " - set 320x200"
#gtf 320 200 59.2
#xrandr "--newmode" "320x200_59.20"  "4.14"  320 304 328 336  200 201 204 208  "-HSync" "+Vsync"
#sleep 1
#xrandr "--addmode" "LVDS" "320x200_59.20"
#sleep 1
#xrandr "-s" "320x200"

echo " - start dosbox"
dosbox -conf ./tie_dosb.conf

#echo " - set 1024x768"
#xrandr "-s" "1024x768"

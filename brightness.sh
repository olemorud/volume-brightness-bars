#!/bin/sh

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

brightnessctl s $1

light=$(( $(brightnessctl g) * 100 / 255))

bar='    '

for i in `seq 1 $(($light/3))`
do
	bar+='─'
done

notify-send -r 2593 -i $SCRIPT_DIR/brightness.png -e -t 1000 "$bar"

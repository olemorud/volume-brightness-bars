#!/bin/sh

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

pactl set-sink-volume @DEFAULT_SINK@ $1

vol=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

if [ $vol -gt 100 ]
then
	vol=100
	pactl set-sink-volume @DEFAULT_SINK@ 100%
fi

volbar='    '

for i in `seq 1 $(($vol/3))`
do
	volbar+='─'
done

notify-send -r 2593 -i $SCRIPT_DIR/volume.png -e -t 1000 "$volbar"

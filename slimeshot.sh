#!/bin/bash

LOCAL_PATH="$HOME/Pictures/slime_img"
DATE=`date -u +%s`
TEMP_FILE="/tmp/out.png"
KEY="" # access key for hirasawa.moe/i goes here

snap_upload() {
	maim -sq "$TEMP_FILE"
	JSON=`curl -s -X POST https://hirasawa.moe/i/pics.php -F "pass=$KEY" -F "photo=@$TEMP_FILE"`
	STATUS=`echo $JSON | jq -r .status`
	VERBOSE=`echo $JSON | jq -r .verbose`
	if [[ $STATUS == 0 ]]; then
		URL=`echo $JSON | jq -r .url`
		echo $URL | xclip -selection clipboard
		echo "$VERBOSE: $URL"
	else
		echo "$VERBOSE"
	fi
}

snap_local() {
	[ ! -d "$LOCAL_PATH" ] && mkdir "$LOCAL_PATH"
	FILENAME="$LOCAL_PATH/$DATE.png"
	maim -sq "$FILENAME"
	echo "Saved to $FILENAME"
	echo "$FILENAME" | xclip -selection clipboard
}

snap_clipboard() {
	maim -sq | xclip -selection clipboard -target image/png
	echo "Saved to clipboard"

}

help() {
	echo "Usage: $0 [command]"
	echo
	echo "Commands: "
	echo "u, upload:	Upload the screenshot to the configured server using HTTP POST; put link on clipboard."
	echo "l, local:	Save screenshot locally and put link on clipboard."
	echo "c, clipboard:	Save screenshot directly to clipboard."
	echo
	echo "Default command is \"upload\" if no command is provided."
}

if [[ $# -gt 0 ]]; then
	case $1 in
		upload | u)
			snap_upload
			;;

		local | l)
			snap_local
			;;

		clipboard | clip | c)
			snap_clipboard
			;;

		*)
			help
			exit 1
			;;

	esac
else
	snap_upload
fi

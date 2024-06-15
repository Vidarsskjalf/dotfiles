#!/bin/bash

case $BLOCK_BUTTON in
	1) notify-send "Test send"$(ps axch -o cmd:15,%cpu --sort=-%cpu | head) ;;
	#3) echo "Right click action" ;;
esac

ps axch -o cmd:15,%cpu --sort=-%cpu | head

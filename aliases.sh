#!/bin/sh
# setup aliases
set -e

if [ "$(id -u)" -ne 0 ]; then
        echo "This script must be run by root" >&2
        exit 1
fi


# ensures a line exists in a file
ensure_line()
{
	FILE=$1
	LINE=$2
	grep -xsq -- "$LINE" $FILE || (echo "" >> $FILE && echo "$LINE" >> $FILE)
}


add_aliases()
{
	user=$1
	home=$2
	alias_file="$home/.bash_aliases"

	if [ -f "$home/.bashrc" ]
	then
		ensure_line "$alias_file" "alias ll='ls -Al'"
		ensure_line "$alias_file" "alias ..='cd ..'"

		ensure_line "$alias_file" "alias dps='docker ps --format \"table {{.Names}}\\\\t{{.Image}}\\\\t{{.Status}}\\\\t{{.RunningFor}}\\\\t{{.Ports}}\"'"
		ensure_line "$alias_file" "alias dcompose='docker-compose'"
		ensure_line "$alias_file" "alias doco='docker-compose'"
		ensure_line "$alias_file" "alias dc='docker-compose'"
		ensure_line "$alias_file" "alias c='docker-compose'"
		ensure_line "$alias_file" "alias dup='docker-compose up -d'"
		ensure_line "$alias_file" "alias dstart='docker-compose start'"
		ensure_line "$alias_file" "alias dstop='docker-compose stop'"
		ensure_line "$alias_file" "alias drestart='docker-compose restart'"
		ensure_line "$alias_file" "alias dlogs='docker-compose logs -f --tail=200'"
		ensure_line "$alias_file" "alias ddown='docker-compose down'"

		# raspberry pi specific
		ensure_line "$alias_file" "alias temp='vcgencmd measure_temp'"
		ensure_line "$alias_file" "alias temps='while true; do temp; sleep 3; done;'"


		chown $USER "$alias_file"

		echo "Set up aliases in $home for $user"
	fi 
}


# add aliases for each user
cd /home
for d in *
do
	add_aliases $d "/home/$d/"
done

add_aliases root /root/

__user_at_host_ps1 ()
{
	if [ "$USER" = "$CONFIGURED_USER" ] &&
	   [ $(hostname -fs) = "$CONFIGURED_HOST" ]; then
		printf "•"
	elif [ "$USER" = "root" ] &&
			[ $(hostname -fs) = "$CONFIGURED_HOST" ]; then
		printf "root"
	else
		printf "$USER@$(hostname -fs)"
	fi
}

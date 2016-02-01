#SCRIPTS ----------------------------------------
	# source "${DOTFILE_SCRIPTS}/helpers/git-prompt.sh"
	# source "${DOTFILE_SCRIPTS}/helpers/proxy-prompt.sh"
	# source "${DOTFILE_SCRIPTS}/helpers/user-at-host-prompt.sh"

#ENV VARIABLES ----------------------------------
	export GIT_PS1_SHOWDIRTYSTATE=1

#PROMPT COMMAND ----------------------
	custom_prompt() {

		#switch coloring if sshing
		PC_USER_HOST=${PC_LIGHTGREEN}
		if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ "$USER" = "root" ]; then
	        PC_USER_HOST=${PC_LIGHTRED}
		else
	        case $(ps -o comm= -p $PPID)
	            in sshd|*/sshd)
	                PC_USER_HOST=${PC_LIGHTRED}
	        esac
		fi

		#TODO: figure out a way to limit current path to percentage of COLS

		#switch prompt based on terminal width
		COLS=$( tput cols )
		if [[ $(tput cols) -lt 50 ]]; then
	        PS1="$( __proxy_ps1 )$PC_USER_HOST[$( __user_at_host_ps1 )]$PC_LIGHTBLUE[\W]$PC_LIGHTPURPLE$(__git_ps1 "[%s]")\n$PC_PURPLE\$$PC_DEFAULT "
		elif [[ $(tput cols) -lt 100 ]]; then
	        PS1="$( __proxy_ps1 )$PC_USER_HOST[$( __user_at_host_ps1 )]$PC_LIGHTBLUE[\W]$PC_LIGHTPURPLE$(__git_ps1 "[%s]")$PC_PURPLE\$$PC_DEFAULT "
	    else
	        PS1="$( __proxy_ps1 )$PC_USER_HOST[$( __user_at_host_ps1 )]$PC_LIGHTBLUE[\w]$PC_LIGHTPURPLE$(__git_ps1 "[%s]")$PC_PURPLE\$$PC_DEFAULT "
	    fi
	}

	PROMPT_COMMAND=custom_prompt


#PS1 VARS ---------------------------------------
	#Sequence	Description
	#\a	The ASCII bell character (you can also type \007)
	#\d	Date in "Wed Sep 06" format
	#\e	ASCII escape character (you can also type \033)
	#\h	First part of hostname (such as "mybox")
	#\H	Full hostname (such as "mybox.mydomain.com")
	#\j	The number of processes you've suspended in this shell by hitting ^Z
	#\l	The name of the shell's terminal device (such as "ttyp4")
	#\n	Newline
	#\r	Carriage return
	#\s	The name of the shell executable (such as "bash")
	#\t	Time in 24-hour format (such as "23:01:01")
	#\T	Time in 12-hour format (such as "11:01:01")
	#\@	Time in 12-hour format with am/pm
	#\u	Your username
	#\v	Version of bash (such as 2.04)
	#\V	Bash version, including patchlevel
	#\w	Current working directory (such as "/home/drobbins")
	#\W	The "basename" of the current working directory (such as "drobbins")
	#\!	Current command's position in the history buffer
	#\#	Command number (this will count up at each prompt, as long as you type something)
	#\$	If you are not root, inserts a "$"; if you are root, you get a "#"
	#\xxx	Inserts an ASCII character based on three-digit number xxx (replace unused digits with zeros, such as "\007")
	#\\	A backslash
	#\[	This sequence should appear before a sequence of characters that don't move the cursor (like color escape sequences). This allows bash to calculate word wrapping correctly.
	#\]	This sequence should appear after a sequence of non-printing characters
	#

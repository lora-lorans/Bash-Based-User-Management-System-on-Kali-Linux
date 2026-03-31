#!/bin/bash

# Get last UID from /etc/passwd and increment it
o_uid=$(cut -d ":" -f 3 /etc/passwd | tail -n 1)
n_uid=$(echo "$(($o_uid + 1))")

# Ask for username input
read -p "enter a username: " username

	# Check if user already exists
	if id $username >> /dev/null 2>&1; then
		echo -e "\e[31mUser exists.\e[0m"
	else
	    # Add user entry to /etc/passwd and create a matching group
		echo "$username:x:$n_uid:$n_uid::/home/$username:/bin/bash" >> /etc/passwd
		echo "$username:x:$n_uid:" >> /etc/group
        # Ask for additional groups and add user to them	
        read -p "enter groupname/names you want to join: " groupname
		usermod -a -G $groupname $username >> /dev/null 2>&1
        # Create home directory and set ownership
		mkdir /home/$username 
		chown $username /home/$username
		chgrp $username /home/$username
        # Copy default skeleton files to home directory
		cp /etc/skel/.* /home/$username >> /dev/null 2>&1 
		    # Set password for the new user
                while true; do
			read -s -p "enter a password: " password
                        	if [[ -z $password ]]; then
                                	read -s -p "enter a password:" password
					                echo -e "$password\n$password" | passwd $username >> /dev/null 2>&1
                                    echo -e "\e[32m\nUser has been added to system!\e[0m"
					exit
                       		else 
                                # Set password and exit loop
                                echo -e "$password\n$password" | passwd $username >> /dev/null 2>&1
					            echo -e "\e[32m\nUser has been added to system!\e[0m"
					exit

                       		fi
                done
	fi

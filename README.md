# User management
You can perform the following operations inside the ./users directory   

You may execute the following command to avoid encoding problems

    export LC_ALL="pt_PT.UTF-8"

Add new users to the group "so", based on a list of users    

    sudo ./append_users.sh alunos_test.txt [so]

Reseting the password of a student 

    sudo ./reset_password.sh fmmb@iscte-iul.pt a88888
   
Delete all the accounts 

    cat /etc/passwd | awk -F':' '/^a[0-9]/ {print $1}' | while read user; do
      echo deluser $user --remove-home
    done
   
Adding students to a new group that does no exist yet 

    sudo addgroup pcl
    sudo ./append_users.sh alunos_pcl.txt pcl
   

# Skeleton

In order to provide the same configuration for all the new users, you must ensure that the content of "./skel" is copied to

	/etc/skel


# System administration

Analyse the permissions of all student users and makes sure that they are set to the default value

	sudo ./system/set_permissions.sh

Backup all users
	
	sudo ./system/backup.sh

You may want to add these scripts to your cron, and send the result to a log file


# Other stuff

Use ASCII only and remove special characters 

    iconv -f UTF-8 -t 'ASCII//TRANSLIT'
   
Analyse running processes 

    ps -eo pcpu,pid,user,args --no-headers| sort -t. -nk1,2 -k4,4 -r |head -n 5



# User management
You can perform the following operations inside the ./users directory   

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


You will need to check and kill processes of some students that are not being carefull. The following command will do it for you. Without parameters, the script only performs the analysis but does nothing. "fkill" performs a "forced kill"
	
	./system/killmultproc.sh [kill|fkill]

You may want top add the following line to the root's cron during the 8th week (last week of trab2)

	*/5 * 5-12 11 * /home/fmmb/bin/killmultproc.sh kill &> /dev/null

Students will be creating IPCS and will not delete them. You may want to do so, once in the while

	./system/ipcrm_all.sh
	./system/ipcrm_all.sh a[0-9]
	./system/ipcrm_all.sh fmmb

You may also want to add a new line to the root's cron during the week 12.

# Other stuff

You may execute the following command to avoid encoding problems

    export LC_ALL="pt_PT.UTF-8"

Use ASCII only and remove special characters 

    iconv -f UTF-8 -t 'ASCII//TRANSLIT'
   
Analyse running processes 

    ps -eo pcpu,pid,user,args --no-headers| sort -t. -nk1,2 -k4,4 -r |head -n 5



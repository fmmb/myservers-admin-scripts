Please make sure that your directory has the correct permissions.
You must prevent other users of looking into your backups and logs.

This repo is now also being used with the TM machine

# User management
You can perform the following operations concerning the user management

Add new users to the group "so", based on a list of users    

    sudo ./append_users.sh alunos_test.txt [so]

Reseting the password of a student 

    sudo ./reset_password.sh a00001 [fmmb@iscte-iul.pt]
   
Delete all the accounts 

    cat /etc/passwd | awk -F':' '/^a[0-9]/ {print $1}' | while read user; do
      echo deluser $user --remove-home
    done
   
Adding students to a new group that does no exist yet 

    sudo addgroup pcl
    sudo ./append_users.sh alunos_pcl.txt pcl
   

# Skeleton

You may want to create the file /etc/skel/.vimrc
	syntax on
	set shiftwidth=4
	set tabstop=4
	set softtabstop=4
	
	"set autoindent
	"set number
	"set expandtab

	set backup
	set writebackup

	set backupdir=~/.vim_backups,.
	set directory=~/.vim_backups,.

please consider adding the following to /etc/skel/.profile
	HISTSIZE=10000
	HISTFILESIZE=50000

# System administration

Analyse the permissions of all student users and makes sure that they are set to the default value

	sudo ./set_permissions.sh

Backup all users
	
	sudo ./backup.sh

You may want to add these scripts to your cron, and send the result to a log file


You will need to check and kill processes of some students that are not being carefull. The following command will do it for you. Without parameters, the script only performs the analysis but does nothing. `fkill` performs a `forced kill`
	
	./killmultproc.sh [kill|fkill]

You may want to add the following line to the root's cron during the 8th week (last week of trab2)

	*/5 * 5-12 11 * /home/admin/scripts/killmultproc.sh kill &> /dev/null

Students will be creating IPCS and will not delete them. You may want to do so, once in the while

	./ipcrm_all.sh
	./ipcrm_all.sh a[0-9]
	./ipcrm_all.sh fmmb

You may also want to add a new line to the root's cron during the week 12.

# Other stuff

You may execute the following command to avoid encoding problems

    export LC_ALL="pt_PT.UTF-8"

Use ASCII only and remove special characters 

    iconv -f UTF-8 -t 'ASCII//TRANSLIT'
   
Analyse running processes 

    ps -eo pcpu,pid,user,args --no-headers| sort -t. -nk1,2 -k4,4 -r |head -n 5


# Giving some previledges to the staff

Also add the users to the group, by adding the users to `/etc/group`. Example:
    
    staff:x:50:ccruz,cecoutinho,jfelicio,rafael,pjp

Add the following lines to `/etc/sudoers` 

    %sudopass ALL=(ALL) ALL, !NSHELLS
    %sudo ALL=NOPASSWD: ALL, !NSHELLS, !NSU
    %staff ALL=NOPASSWD: /usr/bin/ipcs, /bin/kill

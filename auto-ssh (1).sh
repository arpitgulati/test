#!/bin/bash
user=$1

echo the user is $user
for i in `cat serverlist.txt`
do

sshpass  -p 'password' ssh arpitgulati@$i << EOF

tmp=`sudo cat /etc/passwd | grep -w $user`
echo $tmp
	if [ -z $tmp ]
	then
	sudo useradd $1
	sleep 2s
	echo "user added"
	sudo echo "newpassword" | sudo passwd --stdin $user
	else
	echo "USER Already exits . Please try with another user"
	exit 0
	fi
a=`sudo sh -c "cat /etc/ssh/sshd_config | grep AllowUsers"`
echo $a
	if [ -z $a ]
	then
	sudo sh -c "echo 'AllowUsers $user' >> /etc/ssh/sshd_config"
	else 
	sudo sh -c "sed -i 's/\<AllowUsers\>/& $user/' /etc/ssh/sshd_config"
	fi
EOF
done

 

#!/bin/bash 

validate_backup_params(){ 
len=$# 
sor=$1 
des=$2 
kay=$3 
day=$4 

#check that the script received 4 parameters 
if [ $len -eq 4 ] 
then 
        if [ -d $sor ] 
        then 
                echo "you entered right input" 
        else 
        echo "Enter vaild input" 
        echo "Enter the directory to be backed up!!" 
        exit 1 
        fi 
        if [  -d $des ] 
        then 
                echo "you entered right input" 
        else 
        echo "enter vaild input" 
        echo "Enter the directory which should store the backup!!" 
        exit 1 
        fi 
        if [[  $day =~ ^[0-9]+$ ]] 
        then 
                echo "you entered right input" 
        else 
                echo "you entered wrong input of days must be numbers!!" 
                exit 1 
        fi
else 
        echo "This is the file of back up"
echo "***************************" 
echo "Important Note " 
echo "**************" 
echo "We need 4 parameters from you 
1)The directory that contains the backup 

2)the directory which should store eventually the backup 

3)The Key 

4)Number of Days " 
echo "**********************************************************" 
echo "Try again !!" 

        exit 1

fi 
} 

#validate_backup_params $1 $2 $3 $4 

  

  
########################################################################################################
########################################################################################################

backup(){ 
ser=$1
dest=$2
key=$3
days=$4

#i tried thid solution but it takes alot of params
#now=$(date) 
#now2=${now// /_} 
#now3=${now2//:/_} 
#mkdir /$2/$now3

now=$(date "+%Y_%m_%d_%H_%M")
mkdir $dest/$now

cd $ser 
# i tried this to backup the lasted modified files , it runs very well but we don't need all filed in one tar
        #tar -czvf $dest/$(date "+%a_%Y_%m_%d_%k_%M").tar.gz `find . -type f  -mtime -$days` 
        #echo $key | gpg -c --batch --yes --passphrase-fd 0 $dest/$(date "+%a_%Y_%m_%d_%k_%M").tar.gz
        #scp -i main.pem $dest/$(date "+%a_%Y_%m_%d_%k_%M").tar.gz.gpg ubuntu@ip-172-31-31-82:/home/ubuntu/data 
        #rm -rf $dest/$(date "+%a_%Y_%m_%d_%k_%M").tar.gz


############################
#Your script should loop over all directories under the backup directory
# i used for and if to loop. this way backups only the files in dirs without files in the source dir
#for dir in * ; do
#       if [ -d "$dir" ]; then
#               find . -type f -mtime -$days -print | xargs tar -czf "$dir".tar.gz
        #       tar -cvzf  `find . -type f  -mtime -$days` $dir.tar.gz
                #tar -czvf $dest/$(date "+%a_%Y_%m_%d_%k_%M")/$name_$(date "+%a_%Y_%m_%d_%k_%M").tar.gz `find . -type f  -mtime -$days` 
#               echo "$key" | gpg -c --batch --yes --passphrase-fd 0 "$dir".tar.gzi
                #rm -rf $dest/$now/${now}.tar.gz
          
#               fi
#       done
######################################
#i tried this also but the result doesn't match what we need
#for i in * ; do tar -cvzf - "$i" | gpg -c --passphrase $key > "$i".tar.gpg; done
#####################################

#here my final solution
#loop over all dirs and files
for dir in *; do
        if [ -d "$dir" ]; then
                name=$(echo "$dir"| sed s/\ /_/g)_$now
                find . -type f -mtime -$days | xargs tar -cvzf $dest/$now/$name.tar.gz
                echo "$key" | gpg -c --batch --yes --passphrase-fd 0 $dest/$now/$name.tar.gz
                rm -rf $dest/$now/$name.tar.gz
                fi
        
        if [  -f "$dir" ]; then

                find . -type f -mtime -$days | xargs tar -cvzf $dest/$now/file_$now.tar.gz
                echo "$key" | gpg -c --batch --yes --passphrase-fd 0 $dest/$now/file_$now.tar.gz
                rm -rf $dest/$now/file_$now.tar.gz
                fi
        done
#after encrypt all modified files 
#here will gether all encrypted files in one tar file and encrypt it and send it to another server
        cd $dest
        find . -type f -name "*.gpg" | xargs tar -cvzf $now.tgz
        echo "$key" | gpg -c --batch --yes --passphrase-fd 0 $now.tgz
        rm -rf $now.tgz

        #scp -i ~/main.pem $dest/$now.tgz.gpg ubuntu@ip-172-31-31-82:/home/ubuntu/data



} 
 
###################################################################################################
###################################################################################################

validate_restore_params(){ 

len=$# 
sor=$2 
des=$1
kay=$3 


#check that the script received 3 parameters 

if [ $len -eq 3 ] 

then 

        if [ -d $des ] 

        then 

                echo "you entered right input" 

        else 

        echo "Enter vaild input" 

        echo "Enter the directory where the backup file is located !!" 

        exit 1

        fi 

        if [  -d $sor ] 

        then 

                echo "you entered right input" 

        else 

        echo "enter vaild input" 

        echo "Enter the directory to restore to!!" 

        exit 1 

        fi 

  

else 

        echo "This is the file of restore" 

  

echo "***************************" 

echo "Important Note " 

echo "**************" 

echo "We need 3 parameters from you 

1)The directory that contains the backup 

2)the directory which should store eventually the backup 

3)The Key " 
echo "**********************************************************" 

echo "Try again !!" 

        exit 1 
fi 

} 


###################################################################################################
###################################################################################################

restore() {
sor=$1
des=$2
key=$3
mkdir $des/temp
cd $sor

for file in *; do
        if [ -f "$file" ]; then
                if [[ $file == *.gpg ]]; then
                        echo "$key" |  gpg --batch --yes --passphrase-fd 0 --decrypt --output "$des/temp/alaa.tgz" $file
                fi
        fi
        done

cd $des


find $des/temp/ -type f -iname "*.tgz" -exec tar -xvf {} +
#tar -xvf `find var/log/ -iname "*.tgz"`





#we will find the .gpg file
#for i in * ; do tar -cvzf - "$i" | gpg -c --passphrase $key > "$i".tar.gpg; done
#echo "$key" | gpg -d --batch --yes --passphrase-fd 0 "`find . -type f -name "*.gpg" -exec sed "s/.gpg//" {} +`" > $des/temp

#echo "$key" | gpg -d --batch --yes --passphrase-fd 0 "`find . -type f -name "*.gpg" `" | sed "s/.gpg//g" # > $des/temp.sh

#echo "$key" | gpg -d --batch --yes --passphrase-fd 0 "`find . -type f -name "*.gpg" `" 

     #echo "$key" | gpg -d --batch --yes --passphrase-fd 0 `find . -type f  -name "*.gpg"`  > $desti/restor.s/$(echo "$f"| sed s/.gpg//g

 #       find . -type f -name "*.tar" -exec tar -xvzf {} +




}

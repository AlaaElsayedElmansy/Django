# Secure-Backup-Restore


## About The Scripts
Here two bash scripts we can use them if we need to make secure backup to our system OR we need to restore backup to our system.


## 🛠 Tools :
| Tool | Purpose |
| ------ | ------ |
| [ Tar ](https://www.tutorialspoint.com/linux-tar-command) | Tar is used to create and extract archive files. |
| [gnupg ](https://www.poftut.com/install-use-gpg-encrytion-linux-order-encrypt-decrypt-files-folder/) |  It provides encryption, decryption, digital signatures, and signing.. |
| [ Scp ](https://linuxhint.com/linux_scp_command/) | It is used to securely copy files between two servers. |




## Requirements
  Make sure all Tools are installed.


## Steps:
 - Clone The Project
  ```bash
     git clone https://github.com/AlaaElsayedElmansy/Bachup-Restore
  ``` 
  ![2023-05-31 (7)](https://github.com/AlaaElsayedElmansy/Bachup-Restore/assets/112073221/79243975-cca1-4437-aaad-a8ee6bb5c8bd)

 - Excute scripts
 ```bash
    chmod +x backup.sh
    chmod +x restore.sh
``` 

## Run backup.sh
- Before tring run the script
```bash
you need to make sure that you have 4 paramters:
1)The directory that contains the backup 
2)the directory which should store eventually the backup 
3)The Key 
4)Number of Days 
```
- Run
```bash
    . backup.sh /path to the source /path to backup to "key" "days"
``` 
![2023-05-31 (12)](https://github.com/AlaaElsayedElmansy/Bachup-Restore/assets/112073221/6e02c118-6eb0-46c8-b7fe-ca5edda86423)
## Run restore.sh
- Before Run
```bash
you need to make sure that you have 3 paramters:
1)The directory that contains the backup
2)the directory to restore to
3)The Key
```
 - Run
 ```bash
    . restore.sh /source path /destintion path "the same key of backup"
 ``` 
 ![2023-05-31 (8)](https://github.com/AlaaElsayedElmansy/Bachup-Restore/assets/112073221/7820ff03-63b2-473d-9486-c041516e4a57)

# Copying to remote server
- Preparing source server and destination server
You can follow this steps in the link below
```bash
https://blog.microideation.com/2016/05/26/secure-copy-files-scp-between-two-ec2-instances-in-aws/
```
- OR you can ssh the other server
- uncomment this line in backup_restore_lib.sh and adjust it.
```bash
scp -i ~/main.pem $dest/$now.tar.gz.gpg @username:/home/ubuntu/data
```
- Run bach.sh again !!
![2023-05-31 (10)](https://github.com/AlaaElsayedElmansy/Bachup-Restore/assets/112073221/a9a7b27e-8c09-4b80-aa3e-0f79108415b4)
![2023-05-31 (9)](https://github.com/AlaaElsayedElmansy/Bachup-Restore/assets/112073221/c7b4fcc3-0aa0-448a-8a47-9b386bcc0ac8)





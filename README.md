<p align="center"><img src="http://cloud.lrgex.com/s/mCxTfnA2bikjYyZ/download/Dark%20Full%20Logo.png" alt= “” width="400" height="100"></p>

# <div align="center">Backarosa</div>
![GitHub License](https://img.shields.io/github/license/LRGEX/backarosa)
![GitHub Stars](https://img.shields.io/github/stars/LRGEX/backarosa?style=social)
![Docker Pulls](https://img.shields.io/docker/pulls/lrgex/backarosa)


<p align="center">Automated Docker volume backup and restore to most common backends, developed by LRGEX Group, powered by Duplicati and it works on both x86 and ARM architecture.</p> 




## 🔥 Use Cases
- **Host your own Docker backup system** with minimal effort.
- **Automate backups to Google Drive, Dropbox, or Mega Drive**.
- **Keep multiple versions of your backups** for added safety.
- **Works on both servers and personal Raspberry Pi setups.**

  
## List of supported backends :  

1 - **Mega Drive** 

2 - **Dropbox**

3 - **Google Drive** 

4 - **Local folder** 

and we will continue to add more! 


## How to use Backarosa backup command ? 

This section is for **Backarosa backup** commands only, you can find more info about restore function in the **Backarosa restore section**.



### Backup using Mega Drive  :

To **backup** your container you need to run this command 

````dockerfile
docker run -d \
-e KEEP_VERSIONS="2" \
-v <volume_name>:/source:ro \
-v /var/run/docker.sock:/var/run/docker.sock \
-e TZ="Asia/Riyadh" \
-e MEGA_DIR="path/to/folder" \
-e MEGA_EMAIL="Yourmail@example.com" \
-e MEGA_PASSWORD='Yourpassword' \
-e CRON="* * * * *" \
--restart always \
--name <insert_name> lrgex/backarosa backup

````

---------------------------------------------------------------------------------------------------------

### Backup using Dropbox  :

To **backup** your container, first you need to visit this [link](https://duplicati-oauth-handler.appspot.com/?type=dropbox) and get your DROPBOX_AUTHID, copy the token then  run this command 

```dockerfile
docker run -d \
-e KEEP_VERSIONS="2" \
-v <volume_name>:/source:ro \
-v /var/run/docker.sock:/var/run/docker.sock \
-e TZ="Asia/Riyadh" \
-e DROPBOX_DIR="path/to/folder" \
-e DROPBOX_AUTHID='paste your DROPBOX_AUTHID'
-e CRON="* * * * *" \
--restart always \
--name <insert_name> lrgex/backarosa backup
```



---------------------------------------------------------------

### Backup using Google drive :

To **backup** your container, first you need to visit this [link](https://duplicati-oauth-handler.appspot.com/?type=googledrive) and get your GDRIVE_AUTHID, copy the token then  run this command 

```dockerfile
docker run -d \
-e KEEP_VERSIONS="2" \
-v <volume_name>:/source:ro \
-v /var/run/docker.sock:/var/run/docker.sock \
-e TZ="Asia/Riyadh" \
-e GDRIVE_DIR="path/to/folder" \
-e GDRIVE_AUTHID='paste your GDRIVE_AUTHID' \
-e CRON="* * * * *" \
--restart always \
--name <insert_name> lrgex/backarosa backup
```



--------------------



### Backup using Local Folder  :

To backup your container into local folder you need to run this command 

``` dockerfile
docker run -d \
-e KEEP_VERSIONS="2" \
-v <path/to/local_folder>:/backup \
-v <volume_name>:/source:ro \
-v /var/run/docker.sock:/var/run/docker.sock \
-e LOCAL_BACKUP="true" \
-e TZ="Asia/Riyadh" \
-e CRON="* * * * *" \
--restart always \
--name <insert_name> lrgex/backarosa backup			
```



--------------------------



### Backup options

| Environments / Volumes                           | Description                                                  |
| ------------------------------------------------ | ------------------------------------------------------------ |
| **-e KEEP_VERSIONS**                             | [optional] it will increase/decrease the number of backups versions. default is 100 |
| **-v <volume_name>:/source:ro**                  | This is related to your desired volume to be backed up e.g  Sonarr:/source:ro |
| **-v /var/run/docker.sock:/var/run/docker.sock** | This is the Docker sock, we need that's to start and shutdown containers while backing up |
| **-e TZ="Asia/Riyadh"**                          | You need to insert your timezone                             |
| **-e MEGA_DIR="/path/to/folder"**                | This is the path for the directory inside your Mega Drive e.g /mybackups/docker_container_backup |
| -e CRON="* * * * *"                              | [optional] periodic backup using crontab format              |
| **-e DROPBOX_DIR="/path/to/folder"**             | The path for the directory inside your Dropbox drive         |
| **-e GDRIVE_DIR="/path/to/folder"**              | #Path for the directory inside your Google Drive       |
| **-e DROPBOX_AUTHID='paste_Token'**              | First you need to get your token from the link [check backup section], copy it and paste its value here |
| **-e GDRIVE_AUTHID='paste_Token'**               | First you need to get your token from the link [check backup section], copy it and paste its value here |


--------------------------

------------------

----------------



## How to use Backarosa restore command ? 

This section is for Backarosa restore commands only. 

### Restore using Mega Drive : 

To restore using Mega Drive, you need to run this command : 

```dockerfile
docker run --rm \
-v <volume_name>:/source \
-e TZ="Asia/Riyadh" \
-e MEGA_DIR="/path/to/folder" \
-e MEGA_EMAIL="Yourmail@example.com" \
-e MEGA_PASSWORD="Yourpassword" \
-e RESTORE_VERSION="0" \
lrgex/backarosa restore
```

### Restore using Dropbox : 

To restore using Dropbox, you need to run this command, please refer to Dropbox backup section to learn more on how to get your DROPBOX_AUTHID

````dockerfile
docker run --rm \
-v <volume_name>:/source \
-e TZ="Asia/Riyadh" \
-e DROPBOX_DIR="/path/to/folder" \
-e DROPBOX_AUTHID='paste your DROPBOX_AUTHID' \
-e RESTORE_VERSION="0" \
lrgex/backarosa restore
````



### Restore using Google Drive : 

To restore using Google Drive, you need to run this command , please refer to Google Drive backup section to learn more on how to get your GDRIVE_AUTHID 

```dockerfile
docker run --rm \
-v <volume_name>:/source \
-e TZ="Asia/Riyadh" \
-e GDRIVE_DIR="/path/to/folder" \
-e GDRIVE_AUTHID='paste your GDRIVE_AUTHID' \
-e RESTORE_VERSION="0" \
lrgex/backarosa restore
```



### Restore using Local Folder : 

To restore using Local folder, you need to run this command 

```dockerfile
docker run --rm \
-v <path/to/local_folder>:/backup \
-v <volume_name>:/source \
-e LOCAL_BACKUP="true" \
-e TZ="Asia/Riyadh" \
-e RESTORE_VERSION="0" \
lrgex/backarosa restore
```

---------------

### Restore Options 



|   Environments / Volumes   |                         Description                          |
| :------------------------: | :----------------------------------------------------------: |
| **-e RESTORE_VERSION="0"** | [Optional], use this if you want to restore to a specific backup version, default =0, you can see all versions available by using the command find instead of restore in the last command line |



---------------------

--------------------

--------------



## Combining multiple commands 

- With Backarosa you can combine multiple backup commands into one, meaning you can back up your containers on both Google drive and on local folder, here is an example : 

  ```dockerfile
  docker run -d \
  -e KEEP_VERSIONS="2" \
  -v <volume_name>:/source:ro \
  -v <path/to/local_folder>:/backup \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -e LOCAL_BACKUP="true" \
  -e TZ="Asia/Riyadh" \
  -e GDRIVE_DIR="/path/to/folder" \
  -e GDRIVE_AUTHID='paste your DROPBOX_AUTHID' \
  -e CRON="* * * * *" \
  --restart always \
  --name <insert_name> lrgex/backarosa backup
  ```

📜 License
This project is licensed under the Apache License 2.0.
See the LICENSE file for more details.
## Stay Up-to-Date


⭐ ${\normalsize{\textcolor{goldenrod}{\texttt{Star this project}}}}$

Watch for releases and updates.

<img src="https://download.lrgex.com/assets/images/givestar.gif" width="500" alt='github star'/>


## Support Me

Please ⭐ star this repository!

If you found my work useful, consider buying me a [<img src="https://download.lrgex.com/assets/images/coffee.png" height="20" alt='Ko-fi'/>](https://ko-fi.com/lrgex).



   

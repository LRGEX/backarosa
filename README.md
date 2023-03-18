<p align="center"><img src="http://cloud.lrgex.com/s/mCxTfnA2bikjYyZ/download/Dark%20Full%20Logo.png" alt= “” width="400" height="100"></p>

# <div align="center">Backarosa</div>

<p align="center">Automated Docker volume backup and restore to most common backends, developed by LRGEX Group, powered by Duplicati and it works on both x86 and ARM architechture.</p> 

## List of supported backends :  



1 - **Mega Drive** 

2 - **Dropbox**

3 - **Google Drive** 

4 - **Local folder** 

and we will continue to add more! 



## How to use Backarosa backup command ? 

This section is for **Backarosa backup** commands only, you can find more info about restore function in the **Backarosa restore section**.



### Backup using Mega drive  :

To **backup** your container you need to run this command 

````dockerfile
docker run -d \
--keep-versions="2" \ #--optional if you need to increase/decrease versions, default is 3
-v <volume_name>:/source:ro \
-v /var/run/docker.sock:/var/run/docker.sock \
-e TZ="Asia/Riyadh" \ # insert your TimeZone
-e MEGA_DIR="path/to/folder" \ #path for the directioy inside your mega drive
-e MEGA_EMAIL="Yourmail@example.com" \
-e MEGA_PASSWORD="Yourpassword" \
-e CRON="* * * * *" \ #[optional] periodic backup using crontab format 
--restart always \
--name <insert_name> lrgex/backarosa backup

````

---------------------------------------------------------------------------------------------------------

### Backup using Dropbox  :

To **backup** your container, first you need to visit this [link](https://duplicati-oauth-handler.appspot.com/?type=dropbox) and get your DROPBOX_AUTHID, copy the token then  run this command 

```dockerfile
docker run -d \
--keep-versions="2" \ #optional if you need to increase/decrease versions, default is 3
-v <volume_name>:/source:ro \
-v /var/run/docker.sock:/var/run/docker.sock \
-e TZ="Asia/Riyadh" \ # insert your TimeZone
-e DROPBOX_DIR="path/to/folder" \ #path for the directioy inside your Dropbox drive
-e DROPBOX_AUTHID="paste your DROPBOX_AUTHID" \ #visit the link above
-e CRON="* * * * *" \  # [optional] periodic backup using crontab format
--restart always \
--name <insert_name> lrgex/backarosa backup
```



---------------------------------------------------------------

### Backup using Google drive :

To **backup** your container, first you need to visit this [link](https://duplicati-oauth-handler.appspot.com/?type=googledrive) and get your GDRIVE_AUTHID, copy the token then  run this command 

```dockerfile
docker run -d \
--keep-versions="2" \ #[optional] if you need to increase/decrease versions, default is 3
-v <volume_name>:/source:ro \
-v /var/run/docker.sock:/var/run/docker.sock \
-e TZ="Asia/Riyadh" \ # insert your TimeZone
-e GDRIVE_DIR="path/to/folder" \ #path for the directioy inside your Dropbox drive
-e GDRIVE_AUTHID="paste your DROPBOX_AUTHID" \ #visit the link above
-e CRON="* * * * *" \  # [optional] periodic backup using crontab format 
--restart always \
--name <insert_name> lrgex/backarosa backup
```



--------------------



### Backup using Local Folder  :

To backup your container into local folder you need to run this command 

``` dockerfile
docker run -d \
--keep-versions="2" \ #[optional] if you need to increase/decrease versions, default is 3
-v <path/to/local_folder>:/backup \ #this is the folder that you want to backup to
-v <volume_name>:/source:ro \
-v /var/run/docker.sock:/var/run/docker.sock \
-e LOCAL_BACKUP="true" \ 
-e TZ="Asia/Riyadh" \ # insert your TimeZone
-e CRON="* * * * *" \ # [optional] periodic backup using crontab format 
--restart always \
--name <insert_name> lrgex/backarosa backup
```



--------------------------

------------------

----------------



## How to use Backarosa restore command ? 

this section is for Backarosa restore commands only 

### Restore using Mega Drive : 

To restore using Mega Drive, you need to run this command : 

```dockerfile
docker run --rm \
-v <volume_name>:/source \
-e TZ="Asia/Riyadh" \ # insert your TimeZone
-e MEGA_DIR="path/to/folder" \ #path for the directioy inside your mega drive
-e MEGA_EMAIL="Yourmail@example.com" \
-e MEGA_PASSWORD="Yourpassword" \
lrgex/backarosa restore
```

### Restore using Dropbox : 

To restore using Dropbox, you need to run this command, please refer to Dropbox backup section to learn more on how to get your DROPBOX_AUTHID

````dockerfile
docker run --rm \
-v <volume_name>:/source \
-e TZ="Asia/Riyadh" \ # insert your TimeZone
-e DROPBOX_DIR="path/to/folder" \ #path for the directioy inside your mega drive
-e DROPBOX_AUTHID="paste your DROPBOX_AUTHID" \
lrgex/backarosa restore
````



### Restore using Google Drive : 

To restore using Google Drive, you need to run this command , please refer to Google Drive backup section to learn more on how to get your GDRIVE_AUTHID 

```dockerfile
docker run --rm \
-v <volume_name>:/source \
-e TZ="Asia/Riyadh" \ # insert your TimeZone
-e GDRIVE_DIR="path/to/folder" \ #path for the directioy inside your mega drive
-e GDRIVE_AUTHID="paste your GDRIVE_AUTHID" \
lrgex/backarosa restore
```



### Restore using Local Folder : 

To restore using Local folder, you need to run this command 

```dockerfile
docker run --rm \
-v <path/to/local_folder>:/backup \
-v <volume_name>:/source \
-e LOCAL_BACKUP="true" \
-e TZ="Asia/Riyadh" \ # insert your TimeZone
lrgex/backarosa restore
```





---------------------

--------------------

--------------



## Combining multiple commands 

- With Backarosa you can combine multiple backup commands into one, meaning you can backup your containers on both Google drive and on local folder, here is an example : 

  ```dockerfile
  docker run -d \
  --keep-versions="2" \ #[optional] if you need to increase/decrease versions, default is 3
  -v <volume_name>:/source:ro \
  -v <path/to/local_folder>:/backup \ #this is the folder that you want to backup to
  -v /var/run/docker.sock:/var/run/docker.sock \
  -e LOCAL_BACKUP="true" \ 
  -e TZ="Asia/Riyadh" \ # insert your TimeZone
  -e GDRIVE_DIR="path/to/folder" \ #path for the directioy inside your Dropbox drive
  -e GDRIVE_AUTHID="paste your DROPBOX_AUTHID" \ #visit the link above
  -e CRON="* * * * *" \  # [optional] periodic backup using crontab format 
  --restart always \
  --name <insert_name> lrgex/backarosa backup
  ```

   




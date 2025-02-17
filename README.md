<p align="center"><img src="http://cloud.lrgex.com/s/mCxTfnA2bikjYyZ/download/Dark%20Full%20Logo.png" alt="Backarosa Logo" width="400" height="100"></p>

# <div align="center">Backarosa</div>

<p align="center">Automated Docker volume backup and restore to common backends, developed by LRGEX Group. Powered by Duplicati, it supports both x86 and ARM architectures.</p>

---

## 🚀 Features
- 📦 **Automatic backups** for Docker volumes
- 🔄 **Supports multiple cloud storage providers** (Mega, Dropbox, Google Drive)
- 💾 **Local backup support**
- 🏗 **Works on both x86 and ARM architectures**
- ⚡ **Simple and lightweight, powered by Duplicati**

## 📌 Table of Contents
- [Supported Backends](#supported-backends)
- [Getting Started](#getting-started)
- [How to Use Backarosa (Backup)](#how-to-use-backarosa-backup)
- [How to Use Backarosa (Restore)](#how-to-use-backarosa-restore)
- [Backup Options](#backup-options)
- [Restore Options](#restore-options)
- [Support & Contributions](#support-me)
- [License](#license)

## ✅ Supported Backends
1. **Mega Drive**
2. **Dropbox**
3. **Google Drive**
4. **Local Folder**

We will continue adding more!

---

## 🚀 Getting Started
To use Backarosa, first pull the latest Docker image:
```bash
docker pull lrgex/backarosa:latest
```

Then, follow the backup and restore instructions below.

---

## 📂 How to Use Backarosa (Backup)
This section covers **backup commands** only. For restoring, see the **restore section** below.

### 🔹 Backup using Mega Drive
```bash
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
```

### 🔹 Backup using Dropbox
Get your `DROPBOX_AUTHID` from [this link](https://duplicati-oauth-handler.appspot.com/?type=dropbox) and use:
```bash
docker run -d \
-e KEEP_VERSIONS="2" \
-v <volume_name>:/source:ro \
-v /var/run/docker.sock:/var/run/docker.sock \
-e TZ="Asia/Riyadh" \
-e DROPBOX_DIR="path/to/folder" \
-e DROPBOX_AUTHID='your_DROPBOX_AUTHID' \
-e CRON="* * * * *" \
--restart always \
--name <insert_name> lrgex/backarosa backup
```

### 🔹 Backup using Google Drive
Get your `GDRIVE_AUTHID` from [this link](https://duplicati-oauth-handler.appspot.com/?type=googledrive) and use:
```bash
docker run -d \
-e KEEP_VERSIONS="2" \
-v <volume_name>:/source:ro \
-v /var/run/docker.sock:/var/run/docker.sock \
-e TZ="Asia/Riyadh" \
-e GDRIVE_DIR="path/to/folder" \
-e GDRIVE_AUTHID='your_GDRIVE_AUTHID' \
-e CRON="* * * * *" \
--restart always \
--name <insert_name> lrgex/backarosa backup
```

### 🔹 Backup using Local Folder
```bash
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

---

## 🔄 How to Use Backarosa (Restore)

### 🔹 Restore using Mega Drive
```bash
docker run --rm \
-v <volume_name>:/source \
-e TZ="Asia/Riyadh" \
-e MEGA_DIR="/path/to/folder" \
-e MEGA_EMAIL="Yourmail@example.com" \
-e MEGA_PASSWORD="Yourpassword" \
-e RESTORE_VERSION="0" \
lrgex/backarosa restore
```

### 🔹 Restore using Dropbox
```bash
docker run --rm \
-v <volume_name>:/source \
-e TZ="Asia/Riyadh" \
-e DROPBOX_DIR="/path/to/folder" \
-e DROPBOX_AUTHID='your_DROPBOX_AUTHID' \
-e RESTORE_VERSION="0" \
lrgex/backarosa restore
```

### 🔹 Restore using Google Drive
```bash
docker run --rm \
-v <volume_name>:/source \
-e TZ="Asia/Riyadh" \
-e GDRIVE_DIR="/path/to/folder" \
-e GDRIVE_AUTHID='your_GDRIVE_AUTHID' \
-e RESTORE_VERSION="0" \
lrgex/backarosa restore
```

### 🔹 Restore using Local Folder
```bash
docker run --rm \
-v <path/to/local_folder>:/backup \
-v <volume_name>:/source \
-e LOCAL_BACKUP="true" \
-e TZ="Asia/Riyadh" \
-e RESTORE_VERSION="0" \
lrgex/backarosa restore
```

---

## 🛠 Backup Options
| Environment Variable | Description |
|---------------------|-------------|
| `-e KEEP_VERSIONS` | (Optional) Number of backup versions to keep (default: 100) |
| `-e CRON` | (Optional) Schedule periodic backups (crontab format) |

---

## ⭐ Support Me
If you find this project useful, please consider giving it a ⭐ star on GitHub!

☕ **Buy me a coffee:** [![Ko-fi](https://download.lrgex.com/assets/images/coffee.png)](https://ko-fi.com/lrgex)

---

## 📜 License
This project is licensed under the MIT License. See [LICENSE](./LICENSE) for details.

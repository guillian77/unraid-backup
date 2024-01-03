#!/bin/bash

# Allow to backup "BACKUP_DIR_LIST" to target
#
# @param [String] $1 target backup directory (remote or local server/dir).
backup_dirs_to()
{
    if [ -z "$1" ];then
        error "Backup target should be specified!"

        return
    fi

    BACKUPS_DIR="$1"

    title "Backup directories to ${BACKUPS_DIR}"

    if [ ! -d "$BACKUPS_DIR" ]
    then
        error "Backup directory not found."

        info "$BACKUPS_DIR"

        return
    fi

    success "Backup directory found."
    info "$BACKUPS_DIR"

    mkdir -p "$BACKUPS_DIR/crypted"

    for dirIndex in "${!BACKUP_DIR_LIST[@]}"; do
        dir="${BACKUP_DIR_LIST[$dirIndex]}"

        section "Backup $dirIndex"

        if [ ! -d "$dir" ]; then
            error "Directory not found under ${Yel}$dir${NC}."
            info "SKIP, try next backup directory."
            continue
        fi

        success "Directory found under $dir."

        tempBackupDir="${BACKUPS_DIR}crypted/"

        # -- Compress && Crypt
        archiveName="$(date +'%Y-%m-%d')_${dirIndex}.tar.gz"

        info "Compress && Crypt ${archiveName} to ${archiveName}.age."
        info "Target : ${tempBackupDir}${archiveName}.age"

        tar -cz ${dir} | age -r $(age-keygen -y ${SECRET_KEY_PATH}) > "${tempBackupDir}${archiveName}.age"
    done
}

# Backup unraid boot configuration.
generateUnraidFlashBackup()
{
    title "Backuping full unraid configuration."

    targetUnraidFlashName="$(date +'%Y-%m-%d')_flash_full"
    targetUnraidBackupDir="/mnt/user/backups/Unraid/"
    targetUnraidFullPath="${targetUnraidBackupDir}${targetUnraidFlashName}"

    if [ -d "${targetUnraidFullPath}" ]; then
        info "Already exist, remove before: ${targetUnraidFullPath}."
        rm -rf "${targetUnraidFullPath}"
    fi

    info "Copying unraid boot configuration."
    cp -r "/boot" "${targetUnraidFullPath}"

    success "Unraid boot configuration copied"
}

backupPfsense()
{
    title "Backup remote pfsense."

    targetBackupDir="/mnt/user/backups/Pfsense/"
    pfsenseDirName="$(date +'%Y-%m-%d')_pfsense_full"
    fullPath="${targetBackupDir}${pfsenseDirName}"

    if [ -d "${fullPath}" ]; then
        info "Already exist, remove before: ${fullPath}."
        rm -rf "${fullPath}"
    fi

    mkdir -p "$fullPath"

    scp -r admin@firewall.loc:/cf/conf/backup "$fullPath" || true
    scp admin@firewall.loc:/cf/conf/config.xml "$fullPath" || true
}

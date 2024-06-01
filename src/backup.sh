#!/bin/bash

# Allow to save list of backups to target directory.

# BACKUP_DIR_LIST represent a target directory to save backups.
#                 Because backups can be saved on multiple targets.
#                 See: config.sh
#
# @param [String] $1 target backup directory (remote or local server/dir).
backup_dirs_to()
{
    [[ -z "$1" ]]   && error "Backup target should be specified!" && return
    [[ ! -d "$1" ]] && error "Backup directory not found" && return

    target_dir="${1}/crypted"

    title "Current backup directory: ${target_dir}"

    mkdir -p "${target_dir}"

    for dirIndex in "${!BACKUP_DIR_LIST[@]}"; do
        dir="${BACKUP_DIR_LIST[$dirIndex]}"

        section "Backup $dirIndex"

        if [ ! -d "$dir" ]; then
            error "Directory not found under ${Yel}$dir${NC}"
            info "SKIP, try next backup directory"
            continue
        fi

        success "Directory found under $dir"

        archiveName="$(date +'%Y-%m-%d')_${dirIndex}.tar.gz"

        info "Compress && Crypt ${archiveName} to ${archiveName}.age"
        info "Target : ${target_dir}/${archiveName}.age"

        # -- Compress && Crypt
        tar -cz ${dir} | age -r $(age-keygen -y ${SECRET_KEY_PATH}) > "${target_dir}/${archiveName}.age"

        success "${archiveName}.age saved"
    done
}

backupPfsense()
{
    title "Backup remote pfsense"

    targetBackupDir="/mnt/user/backups/Pfsense/"
    pfsenseDirName="$(date +'%Y-%m-%d')_pfsense_full"
    fullPath="${targetBackupDir}${pfsenseDirName}"

    if [ -d "${fullPath}" ]; then
        info "Already exist, remove before: ${fullPath}"
        rm -rf "${fullPath}"
    fi

    mkdir -p "$fullPath"

    errorMessage = "Error when trying to remote copy pfsense"

    scp -r admin@firewall.loc:/cf/conf/backup "$fullPath" || error "${errorMessage}: backup"
    scp admin@firewall.loc:/cf/conf/config.xml "$fullPath" || error "${errorMessage}: config.xml"
}

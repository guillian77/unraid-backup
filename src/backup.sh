#!/bin/bash

# Allow to save list of backups to target directory.

function handle_dirs() {
    target_dir="${1}"

    [[ -z "$target_dir" ]]   && error "Backup target should be specified" && return
    [[ ! -d "$target_dir" ]] && error "Backup directory not found" && return

    title "Current backup directory: ${target_dir}"

    for dir_index in "${!BACKUP_DIR_LIST[@]}"; do
        dir_path="${BACKUP_DIR_LIST[$dir_index]}"

        [[ ! -d "$dir_path" ]]   && error "Directory not found under ${Yel}$dir_path${NC}" && continue

        backup_dirs_to "$dir_path" "$dir_index" "$target_dir"

        [[ $PURGE_TARGET == 1 ]] \
            && purge_directory "$dir_path" "*tar.gz.age" \
            || warning "Pruge currently disabled"
    done
}

# Backup a directory to a target.
#
# Note: directory will be compress and encrypted.
#
# @param [String] $1 Path of directory to backup.
# @param [String] $2 Name of directory to backup.
# @param [String] $3 Target path where save backup.
backup_dirs_to()
{
    dir_path="$1"
    dir_name="$2"
    target_dir="$3"

    [[ -z "$dir_path" ]] && error "Missing directory path parameter" && return
    [[ -z "$dir_name" ]] && error "Missing directory name parameter" && return
    [[ -z "$target_dir" ]]   && error "Missing target directory parameter" && return

    section "Backup $dir_name"

    archiveName="$(date +'%Y-%m-%d')_${dir_name}.tar.gz"

    info "<b>Directory</b>: ${dir_path}"
    info "<b>Name</b>:      ${dir_name}"
    info "<b>Size</b>:      $(du -hs $dir_path)"
    info "<b>Archive</b>:   ${target_dir}/${archiveName}.age"

    tar -cz ${dir_path} | age -r $(age-keygen -y ${SECRET_KEY_PATH}) > "${target_dir}/${archiveName}.age"

    success "${archiveName}.age saved"
}

function purge_directory() {
    target="$1"
    pattern="$2"

    [[ ! -z "$target" ]] || (error "Missing target" && exit 1)
    [[ ! -z "$pattern" ]] || (error "Missing pattern" && exit 1)

    section "Purge $dir_name"

    info "<b>Retention</b>: ${DAYS_RETENTION} day(s)"
    info "<b>Target</b>:    ${target}"
    info "<b>Pattern</b>:   ${pattern}"
    info "<b>Size</b>:      $(du -hs $target)"

    find ${target} -name ${pattern} -mtime +${DAYS_RETENTION} -exec rm -rf {} +

    [[ "$?" != 0 ]] && error "Error when trying to purge unraid old backups" && return

    success "${target} purged"
}

function backup_pfsense() {
    title "Backup remote pfsense"

    targetBackupDir="/mnt/user/backups/Pfsense/"
    pfsenseDirName="$(date +'%Y-%m-%d')_pfsense_full"
    fullPath="${targetBackupDir}${pfsenseDirName}"

    if [ -d "${fullPath}" ]; then
        info "Already exist, remove before: ${fullPath}"
        rm -rf "${fullPath}"
    fi

    mkdir -p "$fullPath"

    error_message="Error when trying to remote copy pfsense"

    scp -r admin@firewall.loc:/cf/conf/backup "$fullPath" || error "${error_message}: backup"
    scp admin@firewall.loc:/cf/conf/config.xml "$fullPath" || error "${error_message}: config.xml"
}

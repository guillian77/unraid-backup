#!/bin/bash

# List of target backup dirs: where "BACKUP_DIR_LIST" will be saved.
BACKUP_TARGET_LIST[a_name]="a/dir/of/remote"

# List of directories to backup.
BACKUP_DIR_LIST[name_to_save]="a/dir/to/save"

# List of directories to purge.
TO_PURGE_DIR_LIST[name_to_purge]="a/dir/to/purge"

DAYS_RETENTION=3

SECRET_KEY_PATH="${SCRIPT_PATH}/key.txt"

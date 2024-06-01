#!/bin/bash

#!/bin/bash

# ----------------------------------------------------------------------------------------------------------------------
# TARGET
# ----------------------------------------------------------------------------------------------------------------------
#
# All related to target.
# This script can handle mutliple targets.
#

# List of target backup dirs: where "BACKUP_DIR_LIST" will be saved.
#
# Renember this list can be purged if PURGE_TARGET is enabled.
BACKUP_TARGET_LIST[a_name]="a/dir/of/remote"

# ----------------------------------------------------------------------------------------------------------------------
# BACKUP
# ----------------------------------------------------------------------------------------------------------------------
#
# All related to directories have to be backuped.
#

# List of directories to backup.
BACKUP_DIR_LIST[name_to_save]="a/dir/to/save"

# ----------------------------------------------------------------------------------------------------------------------
# PURGE
# ----------------------------------------------------------------------------------------------------------------------

# Number of age days a file or directory should be conserved.
DAYS_RETENTION=3

# Enable or disable automatic purge of target locations.
#
# PURGE_TARGET=1 Enable automatic purge.
# PURGE_TARGET=0 Disable automatic purge. Pay attention to remote disk space.
PURGE_TARGET=1

# ----------------------------------------------------------------------------------------------------------------------
# ENCRYPTION
# ----------------------------------------------------------------------------------------------------------------------
SECRET_KEY_PATH="${SCRIPT_PATH}/key.txt"

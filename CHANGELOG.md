# CHANGELOG

## 2024_06_01

### ADD

- Add changelog file.
- Backup script now able to perform purge in the same script.
- `PURGE_TARGET` configuration variable can be used to toggle purge.
- `DAYS_RETENTION` configuration variable is be used to select directory max age before deletion.

### CHANGE
- `TO_PURGE_DIR_LIST` variable has been removed from configuration. It now use `BACKUP_TARGET_LIST` has reference.

### REMOVE
- `src/purge.sh` now handled by `src/backup.sh` source file.

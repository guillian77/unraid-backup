#!/bin/bash

purge()
{
    target="$1"
    pattern="$2"

    info "Purging ${target}"

    [[ ! -z "$target" ]] || (error "Missing target" && exit 1)
    [[ ! -z "$pattern" ]] || (error "Missing pattern" && exit 1)

    find ${target} -name ${pattern} -mtime +${DAYS_RETENTION} -exec rm -rf {} +

    [[ "$?" != 0 ]] && error "Error when trying to purge unraid old backups"

    success "${target} purged"
}

#!/bin/bash

bigTitle()
{
    echo -e "$(date +'%Y-%m-%d') <span style='color: black; font-weight: bold;'>#--------------------------------------------------------------#</span>"
    echo -e "$(date +'%Y-%m-%d') <span style='color: black; font-weight: bold;'># $1</span>"
    echo -e "$(date +'%Y-%m-%d') <span style='color: black; font-weight: bold;'>#--------------------------------------------------------------#</span>"
}

title()
{
    echo -e "$(date +'%Y-%m-%d') <span style='color: #8c8c8c; font-weight: bold;'> ---------------------------------------------------------------"
    echo -e "$(date +'%Y-%m-%d') <span style='color: #8c8c8c; font-weight: 300;'> $1"
    echo -e "$(date +'%Y-%m-%d') <span style='color: #8c8c8c; font-weight: bold;'> ---------------------------------------------------------------"
}

section()
{
    echo -e "$(date +'%Y-%m-%d') <b style='color: #2f4f4f; text-transform: uppercase; font-weight: bold;'>[ > $1 ]</b>"
}

info()
{
    echo -e "$(date +'%Y-%m-%d') <b style='color: cyan;'>INFO</b> $1"
}

success()
{
    echo -e "$(date +'%Y-%m-%d') <b style='color: green;'>SUCCESS</b> $1."
}

error()
{
    echo -e "$(date +'%Y-%m-%d') <b style='color: red;'>ERROR</b> $1."
}

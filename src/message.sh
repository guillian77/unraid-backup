#!/bin/bash

bigTitle()
{
    echo -e "<span style='color: grey;'>$(date +'%Y-%m-%d') #--------------------------------------------------------------#</span>"
    echo -e "<span style='color: grey;'>$(date +'%Y-%m-%d') # $1</span>"
    echo -e "<span style='color: grey;'>$(date +'%Y-%m-%d') #--------------------------------------------------------------#</span>"
}

title()
{
    echo -e "<span style='color: grey;'>$(date +'%Y-%m-%d') ----------------------------------------------------------------"
    echo -e "<span style='color: grey;'>$(date +'%Y-%m-%d') $1"
    echo -e "<span style='color: grey;'>$(date +'%Y-%m-%d') ----------------------------------------------------------------"
}

section()
{
    echo -e "$(date +'%Y-%m-%d') # --- $1"
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

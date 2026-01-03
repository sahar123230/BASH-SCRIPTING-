#!/bin/bash

PASSWD_FILE="/etc/passwd"

check_directory_permissions
() {
    echo "Auditing Home Directories:"
    echo "=============================="

    while IFS=: read -r username _ uid _ _ home _; do
        echo "User: 
$username
"
        echo "----------------"

        user_directory="
$home
"

        find "
$user_directory
" \( -type d -not -perm 755 \) -print
        find "
$user_directory
" \( -type f -uid "+
$uid
" -perm /u=s \) -print
        echo ""
    done < "
$PASSWD_FILE
"
}

check_directory_permissions

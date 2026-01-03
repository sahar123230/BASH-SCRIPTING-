#!/bin/bash

HOSTNAME=$(hostname)
SLACK_WEBHOOK_URL="YOUR_SLACK_WEBHOOK_URL"

check_security_updates
() {
    security_updates=$(apt list --upgradable 2>/dev/null | grep -i security)
    if [[ -n $security_updates ]]; then
        message="Pending security updates detected:\n
$security_updates
"
        send_slack_message "
$message
"
     fi
}

send_slack_message
() {
    local message="
$1
"
    curl -X POST -H "Content-type: application/json" --data "{\"text\":\"[
$HOSTNAME
] 
$message
\"}" "
$SLACK_WEBHOOK_URL
" >/dev/null 2>&1
}

check_security_updates

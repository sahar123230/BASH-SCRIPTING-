#!/bin/bash

API_KEY="YOUR_ABUSEIP_API_KEY"

get_abuse_report
() {
    local ip=$1
    local result=$(curl -s "https://api.abuseipdb.com/api/v2/check?ipAddress=
$ip
&maxAgeInDays=90" \
        -H "Key: 
$API_KEY
" \
        -H "Accept: application/json")
    echo "
$result
"
}

analyze_report
() {
    local report=$1
    local ip=$(echo "
$report
" | jq -r '.data.ipAddress')
    local abuse_confidence_score=$(echo "
$report
" | jq -r '.data.abuseConfidenceScore')
    local is_suspicious=false

    if [[ $abuse_confidence_score -gt 50 ]]; then
        is_suspicious=true
    fi

    echo "IP: 
$ip
"
    echo "Abuse Confidence Score: 
$abuse_confidence_score
"
    if $is_suspicious; then
        echo "Suspicious IP address detected: 
$ip
"
        # You can add alarms or other actions here
    fi
}

last_logins=$(last | awk '!/wtmp/ && !/tty/ && !/boot/  {print $3}')
for ip in $last_logins; do
    report=$(get_abuse_report "
$ip
")
    analyze_report "
$report
"
done

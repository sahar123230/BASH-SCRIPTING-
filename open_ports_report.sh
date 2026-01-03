#!/bin/bash

get_listening_ports
() {
    ss -tuln | awk 'NR>1 && $5 ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:/ {split($5, a, ":"); print a[2]}' | sort -nu
}

get_process_for_port
() {
    local port=$1
    local pid=$(lsof -i :$port | awk 'NR==2 {print $2}')
    local process=$(ps -p $pid -o comm=)
    echo "Port: 
$port
, Process: 
$process
"
}

echo "Open Ports on 
$(hostname)
:"
echo "======================"

listening_ports=$(get_listening_ports)

for port in $listening_ports; do
    get_process_for_port $port
done

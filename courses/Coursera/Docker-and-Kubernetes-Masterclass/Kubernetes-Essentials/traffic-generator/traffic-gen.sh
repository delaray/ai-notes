#!/bin/sh

# Traffic generator script
# Usage: ./traffic-gen.sh <target_url> <number_of_requests>


if [ $# -lt 2 ]; then
    echo "Usage: $0 <target_url> <number_of_seconds>"
    exit 1
fi

TARGET=$1
INTERVAL=$2

echo "Sending requests to $TARGET every $INTERVAL seconds..."

while true; do
    REQUEST_TIME=$(date +"%Y-%m-%d %H:%M:%S")
    RESPONSE=$(curl -s $TARGET > /dev/null) 

    echo "[$REQUEST_TIME] $RESPONSE"
    
    sleep $INTERVAL
done

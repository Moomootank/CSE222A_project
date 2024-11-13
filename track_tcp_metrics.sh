#!/bin/bash

PORT=$1
URL=$2
FILE_TO_DOWNLOAD=$3
OUTPUT_FILE_LOC=$4
KEY_FILE=$5


echo "Monitoring ssthresh and cwnd for port $PORT..."
echo "Press Ctrl+Z to stop."

bash -c "while true; do ss -tin dport = :${PORT} >> ${OUTPUT_FILE_LOC}; sleep 0.1; done" & 
ss_pid=$!


# Start File download from server
echo "Starting SFTP to fetch the file..."
# sftp -i cse222a_key.pem "${URL}:${FILE_TO_DOWNLOAD}" "${FILE_TO_DOWNLOAD}"
sftp -i ./cse222a_key.pem ${URL}:transferred/ <<< $"put ${FILE_TO_DOWNLOAD}"

# Check if SFTP was successful
if [ $? -eq 0 ]; then
    echo "SFTP transfer completed successfully."
else
    echo "SFTP transfer failed."
    # Stop ss monitoring if the transfer fails
    kill "${ss_pid}"
    exit 1
fi

# Stop ss (network monitoring)
echo "Stopping network monitoring (ss)..."
kill "${ss_pid}"


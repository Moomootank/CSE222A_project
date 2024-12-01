#!/bin/bash

PORT=$1
URL=$2
OUTPUT_FILE_LOC=$3

echo "Monitoring ssthresh and cwnd for port $PORT..."
echo "Press Ctrl+Z to stop."

bash -c "while true; do ss -tin sport = :${PORT} >> ${OUTPUT_FILE_LOC}.txt; sleep 0.01; done" & 
ss_pid=$!


# Start sending data to server
echo "Starting iperf3 to send data..."
#sftp -v -i ./cse222a_key.pem ${URL}:transferred/ 2> >(tee ${OUTPUT_FILE_LOC}-throughput.txt) <<< $"put ${FILE_TO_DOWNLOAD}"
iperf3 -c ${URL} -t 60 --cport ${PORT} 2 >> ${OUTPUT_FILE_LOC}-throughput.txt

# Check if iperf3 was successful
if [ $? -eq 0 ]; then
    echo "iperf3 transfer completed successfully."
else
    echo "iperf3 transfer failed."
    # Stop ss monitoring if the transfer fails
    kill "${ss_pid}"
    exit 1
fi

# Stop ss (network monitoring)
echo "Stopping network monitoring (ss)..."
kill "${ss_pid}"


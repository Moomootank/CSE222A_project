#!/bin/bash
URL=$1
OUTPUT_FILE_LOC=$2
NUM_FLOWS=$3

echo "Starting fairness challenge"

echo "Starting iperf3 to send data with main stream"
iperf3 -c ${URL} -t 60 -P ${NUM_FLOWS} 2 >> ${OUTPUT_FILE_LOC}-main.txt

#sleep 30

#echo "Starting iperf3 parallel streams"
#iperf3 -c ${URL} -t 30  2 >> ${OUTPUT_FILE_LOC}-p1.txt &
#iperf3 -c ${URL} -t 30  2 >> ${OUTPUT_FILE_LOC}-p2.txt &

echo "Stopping fairness challenge..."
#!/bin/bash
URL=$1
OUTPUT_FILE_LOC=$2

echo "Starting fairness challenge"


echo "Starting iperf3 to send data with main stream"
iperf3 -c ${URL} -t 90 2 >> ${OUTPUT_FILE_LOC}-main.txt &

sleep 30

echo "Starting iperf3 parallel stream"
iperf3 -c ${URL} -t 30 -p 50000 -P 2 2 >> ${OUTPUT_FILE_LOC}-parallel_1.txt &
#iperf3 -c ${URL} -t 30 -p 50000 2 >> ${OUTPUT_FILE_LOC}-parallel_1.txt &
#iperf3 -c ${URL} -t 30 -p 60000 2 >> ${OUTPUT_FILE_LOC}-parallel_2.txt &

echo "Stopping fairness challenge..."
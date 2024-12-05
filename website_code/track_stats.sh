#!/bin/bash

condition_tag=$1

echo "Outputting to ${condition_tag}_ss_out.txt"
echo "Press Ctrl+Z to stop."

rm "${condition_tag}_ss_out.txt"

bash -c "while true; do ss -tinO sport == 5000 >> ${condition_tag}_ss_out.txt; sleep 0.01; done" &
ss_pid=$!

#echo "Running bmon ..."
bash -c "bmon -r .01 -R .01 -o ascii > ${condition_tag}_bmon_out.txt" &

sleep 10


#echo "Stopping throughput monitoring (bmon)..."
kill $(pidof bmon)

# Stop ss (network monitoring)
echo "Stopping network monitoring (ss)..."
kill "${ss_pid}"

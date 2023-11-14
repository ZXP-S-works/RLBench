#!/bin/bash

source /home/zxp/.bashrc
source ~/anaconda3/etc/profile.d/conda.sh
conda activate c2f_bi_equ

args="
"
jn=""

m_run=1

for (( i=1; i<=$m_run; i++ ))
do
    python ../tools/dataset_generator.py ${args} $@ & 2>&1
    PIDS+=($!)
done

# wait for all processes to finish, and store each process's exit code into array STATUS[].
for pid in ${PIDS[@]}; do
  echo "pid=${pid}"
  wait ${pid}
  STATUS+=($?)
done

# after all processed finish, check their exit codes in STATUS[].
i=0
for st in ${STATUS[@]}; do
  if [[ ${st} -ne 0 ]]; then
    echo "$i failed"
    exit 1
  else
    echo "$i finish"
  fi
  ((i+=1))
done

exit

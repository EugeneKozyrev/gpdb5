#!/bin/bash

export NAME=segment

echo master > /tmp/gpdb-hosts

for S in `seq 1 12`
do
 echo ${NAME}-${S}
 ping -c 1 ${NAME}-${S}
 if [[ $? == 0 ]]; then
  echo "Adding ${NAME}-${S}"
  echo ${NAME}-${S} >> /tmp/gpdb-hosts
 else
  echo "..."
 fi
done

exit 0
#
# Not needed any longer with --scale option in compose 1.13
#
for SS in `seq 1 4`
do
 for S in `seq 1 4`
 do 
  ping -c 1 ${NAME}${SS}-${S}
  if [[ $? == 0 ]]; then
   echo "Adding ${NAME}${SS}-${S}"
   echo ${NAME}${SS}-${S} >> /tmp/gpdb-hosts
  else
   echo "..."
  fi
 done
done

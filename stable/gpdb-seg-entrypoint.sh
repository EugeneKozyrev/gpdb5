#!/bin/bash 

source /usr/local/gpdb/greenplum_path.sh

# --------------------------------------------------------- #
# >>>>>>>> Trap signals here for graceful shutdown <<<<<<<< #
# --------------------------------------------------------- #

function cleanup {
exit
}

trap cleanup SIGTERM SIGINT SIGHUP

sudo mkdir -p /gpdata/segments
sudo chown -R gpadmin: /gpdata

# --------------------------- #
# >>>>>>>> Start SSH <<<<<<<< #
# --------------------------- #

sudo /usr/bin/ssh-keygen -A
sudo /usr/sbin/sshd &

while true
do
  ps aux | grep -q postgres || break
  sleep 10
done

while true
do
  gpstate -s || break
  sleep 10
done

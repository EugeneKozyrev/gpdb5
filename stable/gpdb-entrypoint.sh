#!/bin/bash

source /usr/local/gpdb/greenplum_path.sh

# --------------------------------------------------------- #
# >>>>>>>> Trap signals here for graceful shutdown <<<<<<<< #
# --------------------------------------------------------- #

function cleanup {
gpstop -a
exit
}

trap cleanup SIGTERM SIGINT SIGHUP

# --------------------------- #
# >>>>>>>> Start SSH <<<<<<<< #
# --------------------------- #

sudo /usr/bin/ssh-keygen -A
sudo /usr/sbin/sshd &

# ------------------------------------- #
# >>>>>>>> Initialize instance <<<<<<<< #
# ------------------------------------- #

if [ ! -s "$MASTER_DATA_DIRECTORY" ]; then

export MASTER_HOSTNAME=master

/usr/local/bin/discover_segments.sh
gpssh-exkeys -f /tmp/gpdb-hosts
sudo mkdir -p /gpdata/master /gpdata/segments
sudo chown -R gpadmin: /gpdata
gpinitsystem -a -c  /tmp/gpinitsystem.conf -h /tmp/gpdb-hosts
psql -d template1 -c "alter user gpadmin password 'greenplum'"
createdb gpadmin
gpstop -a
echo "host all all 0.0.0.0/0 md5" >> $MASTER_DATA_DIRECTORY/pg_hba.conf
fi

# -------------------------------- #
# >>>>>>>> Start instance <<<<<<<< #
# -------------------------------- #

gpstart -a

while true
do
  gpstate || break
  sleep 10
done

#!/bin/bash

# Start ZooKeeper
echo "Start ZooKeeper..."
exec sudo service zookeeper restart >>/dev/null & 

# Start Mesos master
echo "Start Mesos master..."
exec /usr/sbin/mesos-master --zk=zk://127.0.0.1:2181/mesos --quorum=1 --work_dir=/var/lib/mesos --log_dir=/log/mesos  >>/dev/null 2>&1 &

# Start Mesos slave
echo "Start Mesos slave..."
exec /usr/sbin/mesos-slave --containerizers=docker,mesos --master=zk://127.0.0.1:2181/mesos --log_dir=/log/mesos >>/dev/null 2>&1 &

# Start Marathon
echo "Start Marathon..."
exec sudo service marathon start >>/dev/null &

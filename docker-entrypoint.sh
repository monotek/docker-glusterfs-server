#!/bin/bash

set -e

if [ "$1" = 'glusterfs-server' ]; then
  GLUSTERFS_HOSTNAME="$(hostname)"

  echo "starting glusterfs-server"
  /usr/sbin/glusterd -p /var/run/glusterd.pid

  echo "creating tmpfs"
  mkdir -p ${GLUSTERFS_DIR}
  mount -t tmpfs -o size=1G none ${GLUSTERFS_DIR}

  echo "creating glusterfs mount"
  gluster volume create glusterfsvolume ${GLUSTERFS_HOSTNAME}:${GLUSTERFS_DIR} force

  gluster volume info

  sleep infinity
fi

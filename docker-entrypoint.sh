#!/bin/bash

set -e

if [ "$1" = 'glusterfs-server' ]; then
  GLUSTERFS_HOSTNAME="$(hostname)"

  echo "starting glusterfs-server"
  /usr/sbin/glusterd -p /var/run/glusterd.pid

  echo "creating ${GLUSTERFS_DIR} directory"
  mkdir -p ${GLUSTERFS_DIR}

  if [ "${GLUSTERFS_TMPFS}" = "true" ]; then
    echo "creating tmpfs"
    mount -t tmpfs -o size=${GLUSTERFS_TMPFS_SIZE} none ${GLUSTERFS_DIR}
  fi

  echo "creating glusterfs mount"
  gluster volume create ${GLUSTERFS_VOLUME} ${GLUSTERFS_HOSTNAME}:${GLUSTERFS_DIR} force
  gluster volume start ${GLUSTERFS_VOLUME}
  gluster volume info

  sleep infinity
fi

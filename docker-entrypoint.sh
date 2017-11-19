#!/bin/bash

set -e

if [ "$1" = 'glusterfs-server' ]; then
  GLUSTERFS_HOSTNAME="$(hostname)"

  echo "starting glusterfs-server"
  /usr/sbin/glusterd /var/run/glusterd.pid --debug &
  sleep 3

  if [ ! -d "${GLUSTERFS_DIR}" ]; then
    echo "creating ${GLUSTERFS_DIR} directory"
    mkdir -p "${GLUSTERFS_DIR}"

    if [ "${GLUSTERFS_TMPFS}" = "true" ]; then
      echo "creating tmpfs"
      mount -t tmpfs -o size=${GLUSTERFS_TMPFS_SIZE} none ${GLUSTERFS_DIR}
    fi

    gluster volume create ${GLUSTERFS_VOLUME} ${GLUSTERFS_HOSTNAME}:${GLUSTERFS_DIR} force
  fi

  echo "starting cluster volume"
  gluster volume start ${GLUSTERFS_VOLUME}
  gluster volume info

  sleep infinity
fi

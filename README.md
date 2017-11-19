# docker-glusterfs-server

glusterfs serving 1gb tmpfs volume with name gv0

Run:
* docker run --rm --name glusterfs-server --privileged=true -ti monotek/docker-glusterfs-server

Mount on client:
* mount -t glusterfs glusterfs-server:/gv0 /mnt

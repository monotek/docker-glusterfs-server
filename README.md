# docker-glusterfs-server

glusterfs serving 1gb tmpfs volume with name glusterfsvolume

Run:
* docker run --rm --name glusterfs-server --privileged=true -ti monotek/docker-glusterfs-server

Mount on client:
* mount -t glusterfs glusterfs-server:/glusterfsvolume /mnt

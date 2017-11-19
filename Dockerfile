FROM ubuntu:16.04
MAINTAINER André Bauer <monotek23@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive
ARG GLUSTERFS_VERSION=3.12

ENV GLUSTERFS_DIR /opt/zammad
ENV GLUSTERFS_TMPFS true
ENV GLUSTERFS_TMPFS_SIZE 1G
ENV GLUSTERFS_VOLUME gv0

RUN apt-get update && \
    apt-get -y install software-properties-common && \
    add-apt-repository ppa:gluster/glusterfs-${GLUSTERFS_VERSION} && \
    apt-get update && \
    apt-get -y install glusterfs-server && \
    apt-get -y remove software-properties-common && \
    apt-get -y autoremove && \
    apt-get clean

# docker init
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["glusterfs-server"]

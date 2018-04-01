FROM ubuntu:xenial
MAINTAINER Dmitrii Ageev <d.ageev@gmail.com>

# Set environment
ENV APPLICATION "ansible"
ENV VERSION "2.5.0"
ENV EXECUTABLE "/bin/bash"

# Install software package
RUN apt update
RUN apt -y upgrade
RUN apt install -y software-properties-common
RUN apt-add-repository -y ppa:ansible/ansible
RUN apt install --no-install-recommends -t xenial-updates -y \
    curl \
    less \
    tar \
    gzip \
    bzip2 \
    ansible \
    vim-tiny \
    python-pip \
    python3-pip \
    sudo
RUN apt -y update
RUN apt -y dist-upgrade
RUN apt -y upgrade

# Remove unwanted stuff
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Copy scripts and pulse audio settings
COPY files/wrapper /sbin/wrapper
COPY files/entrypoint.sh /sbin/entrypoint.sh
COPY files/hosts /etc/hosts

# Proceed to the entry point
ENTRYPOINT ["/sbin/entrypoint.sh"]

FROM ubuntu:xenial
MAINTAINER Dmitrii Ageev <d.ageev@gmail.com>

# Set environment variables
ENV UNAME developer
ENV HOME /home/developer
ENV DEBIAN_FRONTEND noninteractive

# Create a user and add it to audio group
RUN groupadd -g 1000 $UNAME
RUN useradd -u 1000 -g 1000 -G audio -m $UNAME

# Install software package
RUN apt update
RUN apt install -y software-properties-common less vim-tiny
RUN apt-add-repository ppa:ansible/ansible
RUN apt update
RUN apt install -y ansible

# Run a software piece as non-root user
USER $UNAME
WORKDIR $HOME/ansible
CMD /bin/bash

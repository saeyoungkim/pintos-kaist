FROM ubuntu:latest

ARG USERNAME
ARG PASSWORD
ARG UID
ARG GID

RUN apt-get update && apt-get install -y \
    git \
    openssh-server \
    vim \
    sudo \
    gcc \
    gdb \
    make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set sshd setting
RUN mkdir /run/sshd \ 
    && chmod 0755 /run/sshd

EXPOSE 20022

RUN groupadd -g ${GID} dev
RUN useradd -rm -d /home/${USERNAME} -s /bin/bash -g dev -u ${UID} ${USERNAME} 
RUN gpasswd -a ${USERNAME} sudo
RUN echo "${USERNAME}:${PASSWORD}" | chpasswd

# Start sshd
CMD ["/usr/sbin/sshd", "-D"]

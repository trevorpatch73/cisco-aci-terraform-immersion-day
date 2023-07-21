FROM ubuntu:18.04

COPY . /

RUN chmod -R 777 /modules /data

RUN apt -y update \
    && apt -y install git software-properties-common gnupg2 curl \
    && curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg \
    && install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/ \
    && apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    && apt -y install terraform

RUN terraform init

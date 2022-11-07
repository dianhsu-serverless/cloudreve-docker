FROM ubuntu:latest

RUN apt-get update && apt-get install curl unzip jq -y

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 ubuntu
USER ubuntu
WORKDIR /home/ubuntu

RUN curl -L  $(curl -s  https://api.github.com/repos/cloudreve/Cloudreve/releases/latest | jq '.assets' | jq '.[].browser_download_url' | grep linux_amd64.tar.gz | cut -d '"' -f 2) -o dist.tar.gz && \
    tar -zxvf dist.tar.gz && \
    rm dist.tar.gz
COPY conf.ini /home/ubuntu/conf.ini

EXPOSE 5212

CMD ["/home/ubuntu/cloudreve", "-c", "/home/ubuntu/conf.ini"]

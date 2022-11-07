FROM ubuntu:latest

RUN apt-get update && apt-get install curl unzip -y

RUN curl -L  $(curl -s  https://api.github.com/repos/cloudreve/Cloudreve/releases/latest | jq '.assets' | jq '.[].browser_download_url' | grep linux_amd64.tar.gz | cut -d '"' -f 2) -o dist.tar.gz && \
    tar -zxvf dist.tar.gz && \
    rm dist.tar.gz

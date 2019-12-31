FROM ubuntu:latest
ENV LANG C.UTF-8a
RUN apt-get update &&  apt-get -y install vim curl jq


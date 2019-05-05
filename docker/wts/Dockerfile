FROM ubuntu:18.04

RUN apt update
ENV DEBIAN_FRONTEND "noninteractive"
ENV APT_INSTALL "apt install --no-install-recommends -y"
RUN $APT_INSTALL python python-pip git
RUN $APT_INSTALL vim tzdata
# set timezone
RUN $APT_INSTALL iputils-ping netcat
RUN pip install wheel setuptools
RUN git clone https://github.com/uc-cdis/workspace-token-service /root/workspace-token-service
WORKDIR /root/workspace-token-service
RUN pip install .
FROM ubuntu:18.04

RUN apt update
ENV APT_INSTALL "apt install --no-install-recommends -y"
RUN $APT_INSTALL python3 python3-pip git
RUN $APT_INSTALL golang-go
RUN $APT_INSTALL iputils-ping netcat
ENV GOPATH /root/go
#RUN mkdir -p $GOPATH/src/uc-cdis
#RUN git clone https://github.com/uc-cdis/gen3-fuse.git $GOPATH/src/uc-cdis/gen3-fuse \
#    && cd $GOPATH/src/uc-cdis/gen3-fuse
RUN go get github.com/uc-cdis/gen3-fuse
WORKDIR $GOPATH/src/github.com/uc-cdis/gen3-fuse
RUN go build


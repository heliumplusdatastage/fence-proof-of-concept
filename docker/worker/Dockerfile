FROM ubuntu:18.04

## see https://github.com/uc-cdis/gen3-fuse for docs

RUN apt update
ENV APT_INSTALL "apt install --no-install-recommends -y"
RUN $APT_INSTALL file ca-certificates golang-go git
RUN update-ca-certificates
ENV GOPATH /root/go
ENV PATH="${GOPATH}/bin:${PATH}"

# setup instructions in docs do not build so use below 
RUN go get github.com/uc-cdis/gen3-fuse
ENV GEN3FUSEPATH $GOPATH/src/github.com/uc-cdis/gen3-fuse
WORKDIR $GEN3FUSEPATH

# correct gen3-fuse HEAD 071719 "gcs://" to fence 4.0.0's "gs://"
RUN sed -i 's/gcs/gs/g' internal/gen3fuse.go

# enable more debugging
RUN sed -i 's\// FuseLog\FuseLog\g' internal/gen3fuse.go

RUN go build

# install needed fuse binary
RUN $APT_INSTALL fuse

ENV FENCE_HOST ${FENCE_HOST}
ENV WTS_URL ${WTS_URL}

# correct import of tests (HEAD 072519)
RUN sed -i 's\gen3-fuse/internal\github.com/uc-cdis/gen3-fuse/internal\g' tests/gen3fuse_test.go
COPY dev-manifest.json ${GEN3FUSEPATH}

# target dir for gen3-fuse fs to be mounted
RUN mkdir /mnt/gen3-fuse

## test gen3fuse fs
# Usage: gen3fuse  <path to config yaml file> <path to manifest json file> <directory to mount> <hostname> <workspace token service url> [<api key>]

# test read from bucket
CMD cat /dev/null > fuse_log.txt ; ${GEN3FUSEPATH}/gen3-fuse ${GEN3FUSEPATH}/local-config.yaml ${GEN3FUSEPATH}/dev-manifest.json /mnt/gen3-fuse ${FENCE_HOST} ${WTS_URL} ; cat fuse_log.txt ; ls -l /mnt/gen3-fuse/by-guid ; echo "cat /mnt/gen3-fuse/by-guid/fbd5b74e-6789-4f42-b88f-f75e72777f5d" ; cat /mnt/gen3-fuse/by-guid/fbd5b74e-6789-4f42-b88f-f75e72777f5d ; while true; do sleep 1; done 

## gen3fuse tests
### CMD go test tests/gen3fuse_test.go -hostname=${FENCE_HOST} -wtsURL=${WTS_URL} ; while true; do sleep 1; done 

## general debugging tools
RUN $APT_INSTALL net-tools iputils-ping netcat iproute2 curl less vim

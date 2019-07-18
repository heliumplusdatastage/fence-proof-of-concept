FROM ubuntu:18.04

RUN apt update
ENV APT_INSTALL "apt install --no-install-recommends -y"
RUN $APT_INSTALL file ca-certificates golang-go git
RUN update-ca-certificates
ENV GOPATH /root/go
WORKDIR $GOPATH
RUN go get github.com/uc-cdis/gen3-fuse
ENV GEN3FUSEPATH $GOPATH/src/github.com/uc-cdis/gen3-fuse
WORKDIR $GEN3FUSEPATH

# must change "localhost:8001" to ":8001" in code st mock_wts_server listens on container nw i/f
RUN sed -i 's/localhost:8001/:8001/g' tests/mock_wts_server.go

RUN go build tests/mock_wts_server.go

# mock WTS hits fence /user path so mod fence container to expose it
# <commons url> is the base URL for the fence deployment
# <api key> is used to generate access tokens for logged-in user when mock WTS is called
# mock_wts_server <commons url> <api key>

ENV COMMONS_URI ${COMMONS_URI}
ENV API_KEY ${API_KEY}

RUN $APT_INSTALL net-tools iputils-ping netcat iproute2 dnsutils curl less vim

EXPOSE 8001
CMD ${GEN3FUSEPATH}/mock_wts_server $COMMONS_URI $API_KEY

FROM ubuntu:18.04

RUN apt update
ENV DEBIAN_FRONTEND "noninteractive"
ENV APT_INSTALL "apt install --no-install-recommends -y"
RUN $APT_INSTALL python python-pip git
RUN $APT_INSTALL vim tzdata sudo
RUN $APT_INSTALL postgresql-client-10
RUN $APT_INSTALL iputils-ping netcat
RUN pip install wheel setuptools

# add user
RUN groupadd fence_microservice && \
    useradd -s /bin/bash -m -g fence_microservice fence_microservice && \
    echo "fence_microservice ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/fence_microservice
USER fence_microservice

# install fence
ENV FENCEPATH /home/fence_microservice/fence
RUN git clone https://github.com/uc-cdis/fence $FENCEPATH
WORKDIR $FENCEPATH
RUN sudo $APT_INSTALL libpq-dev
RUN pip install --user -r requirements.txt
RUN pip install --user -r dev-requirements.txt
RUN python setup.py develop --user
ENV PATH "/home/fence_microservice/.local/bin:$PATH"
#RUN echo "export PATH=\"/home/fence_microservice/.local/bin:$PATH\"" >> ~/.profile
# "storageclient @ git+https://github.com/uc-cdis/storage-client.git@0.2.2#egg=storageclient-0.2.2"

# generate keypair for JWT signing
RUN openssl genpkey -algorithm RSA -out jwt_private_key.pem -pkeyopt rsa_keygen_bits:2048
RUN openssl rsa -pubout -in jwt_private_key.pem -out jwt_public_key.pem

# initialize config
RUN python cfg_help.py create

# edit config file
ENV FENCECFG /home/fence_microservice/.gen3/fence/fence-config.yaml

# copy files
COPY user.yaml $FENCEPATH
COPY entrypoint.sh $FENCEPATH
COPY uwsgi.ini $FENCEPATH
COPY ../gen-nonce.py $FENCEPATH

EXPOSE 8080

ENTRYPOINT ["bash", "/home/fence_microservice/fence/entrypoint.sh"]
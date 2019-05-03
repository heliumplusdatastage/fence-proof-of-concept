FROM ubuntu:18.04

RUN apt update
ENV DEBIAN_FRONTEND "noninteractive"
ENV APT_INSTALL "apt install --no-install-recommends -y"
RUN $APT_INSTALL python3 python3-pip git
RUN $APT_INSTALL vim tzdata
# set timezone
RUN $APT_INSTALL postgresql-client-10
RUN $APT_INSTALL iputils-ping netcat
RUN pip3 install wheel setuptools
ENV FENCEPATH /root/fence
RUN git clone https://github.com/uc-cdis/fence $FENCEPATH
RUN cd $FENCEPATH \
    && pip3 install -r requirements.txt \
    && python3 setup.py develop \
    # uses hostname 'database', assumed set externally, for example via compose
    && psql -h database -U test postgres -c 'create database fence_test_tmp'



EXPOSE 8080
#ENTRYPOINT '/bin/bash -i'
#CMD ['bash', '-i']
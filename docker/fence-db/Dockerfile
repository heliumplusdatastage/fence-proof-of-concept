FROM postgres:10

# install fence to get the userdatamodel-init command
# might just be able to install pip package 'userdatamodel'
RUN pip install wheel setuptools
ENV FENCEPATH /root/fence
RUN git clone https://github.com/uc-cdis/fence $FENCEPATH \
WORKDIR cd $FENCEPATH \
RUN pip install -r requirements.txt \
    && python setup.py develop

# initialize database
RUN psql -U postgres postgres -c 'create database fence_test_tmp'
RUN psql -U postgres postgres -c 'create database fence_test'
RUN userdatamodel-init --db fence_test --username postgres --password test
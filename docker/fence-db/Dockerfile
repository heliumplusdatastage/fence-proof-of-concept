#
# for runtime init of Fence database tables with Gen3 data model
#

# NB: if script fails at runtime, a restart will not re-run script bc data dir will not be empty
# see https://hub.docker.com/_/postgres

FROM postgres:10

RUN apt-get update && apt-get install -y \
    python-pip
RUN pip install psycopg2-binary userdatamodel

# these are for init-db.sh
ENV POSTGRES_USER ${POSTGRES_USER}
ENV POSTGRES_DB ${POSTGRES_DB}

# copy init script to following image dir st postgres image will run it at startup
COPY init-db.sh /docker-entrypoint-initdb.d

## multistage build to wipe out image history seems to be unnecessary  


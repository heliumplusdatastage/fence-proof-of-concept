#!/bin/bash

# wait for db
while ! nc -z db 5432; do sleep 3; done

# edit config file on startup
sed -i "s|DB\: .*|DB\: 'postgresql\:\/\/postgres\:${PGPASSWORD}@database\:5432\/fence'|g" $FENCECFG

fence-create sync --yaml user.yaml

tail -f /dev/null
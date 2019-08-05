#!/bin/bash

#
# Update certificate authority index -
# environment may have mounted more authorities
#
update-ca-certificates
#
# Kubernetes may mount jwt-keys as a tar ball
#
if [ -f /fence/jwt-keys.tar ]; then
  (
    cd /fence
    tar xvf jwt-keys.tar
    if [ -d jwt-keys ]; then
      mkdir -p keys
      mv jwt-keys/* keys/
    fi
  )
fi

## nginx shim to use standard weblog format that includes remote_addr
sed -i "s/access.log  json/access.log main/g" /etc/nginx/nginx.conf

## initialization shim to set up fence for testing
fence-create client-create --client fence-test-client0 --urls http://<***FQHN of fence endpoint***>/ --username a-user-responsible-for-this-oauth-client
fence-create sync --yaml /fence/user.yaml

## create a storage bucket linked to the DBGAP user/project authZ defined in user.yaml
## --public False causes fence-create to create read GBAG and write GBAB
fence-create google-bucket-create --unique-name dev-helx-auth-data-bucket2 --public False --project-auth-id project_b

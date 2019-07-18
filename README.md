# fence-proof-of-concept

Proof of concept project for Fence and gen3-fuse running in Docker containers.

NB: For a standalone deployment (e.g., using docker-compose) don't leave containers running for long periods on a VM host. Docker modifies iptables to allow world exposure of published ports, overriding restrictive settings of other firewalls such as ufw. 

## Setup (for using docker-compose)

Use Docker Community Edition (CE) 19.03.0-rc3 and docker-compose 1.24.1 (or later)

See SETUP REQUIREMENTS at top of docker-compose.yml

### Generate an API key for a user 

This step is necessary the first time through or when a previously-generated API key expires.

Choose a user that will log in to the system through (for example) Google.

Bring up Fence:
```
$ docker-compose up fence
```

When Fence comes up it creates an Oauth2 client and outputs a line like:
```
fence_1        | ('6rrZI4I98zNB04x2O4o0iKw4TIvKiBf38ceMGm1l', 'yerb5yrPJvxCjhUPjLrm43aK6Av3PBDRUdMojwDb8zK30xhF6QpYaFk') 
```

Save this somewhere. The client_id is the first string in the output tuple.

Log in to Fence container to get API key per https://github.com/heliumplusdatastage/fence-proof-of-concept/wiki/Fence-usage-scenarios#get-or-generate-user-api-key. Use the client_id for this.

In the .env file set API_KEY (under wts-stub service) to the API key from the step above.

### Launch the worker container
```
$ docker-compose up worker
```
## References

Fence: https://github.com/uc-cdis/fence
Gen3 FUSE: https://github.com/uc-cdis/gen3-fuse
Workspace Token Service: https://github.com/uc-cdis/workspace-token-service

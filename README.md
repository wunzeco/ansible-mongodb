MongoDB
====

Ansible role to install and configure MongoDB.

Features:
- installs mongodb community edition
- updates mongodb config
- Creates replica set (without access control or authentication)


> **WARNING:**
>
>    Ensure you quote and lowercase any booleans. Unfortunately, mongodb
>    config options parser ONLY recognises "true" and "false" as boolean
>    values. Any other variation (e.g. True, False, etc) is seen as a
>    string and will result in parser failure on mongod start.
>
> (See: https://github.com/mongodb/mongo/blob/master/src/mongo/util/options_parser/options_parser.cpp)


## Example

### MongoDB Standalone installation

```
  vars:
    mongodb_net:
      port: 27017
      bindIp: "{{ ansible_eth1.ipv4.address }}"

  roles:
    - wunzeco.mongodb
```

### MongoDB Replica Set installation

```
- hosts: node1.internal				# SECONDARY

  vars:
    mongodb_net:
      port: 27017
      bindIp: "{{ ansible_eth0.ipv4.address }}"
    mongodb_replication:
      replSetName: rs0
    mongodb_is_primary: false
    mongodb_replica_set_members: [ "node0.internal:27017", "node1.internal:27017" ]

  roles:
    - wunzeco.mongodb


- hosts: node0.internal				# PRIMARY

  vars:
    mongodb_net:
      port: 27017
      bindIp: "{{ ansible_eth0.ipv4.address }}"
    mongodb_replication:
      replSetName: rs0
    mongodb_is_primary: true
    mongodb_create_replica_set: true
    mongodb_replica_set_members: [ "node0.internal:27017", "node1.internal:27017" ]

  roles:
    - wunzeco.mongodb
```

It is **recommended** that your replica set members have resolveable names. So
use FQDN for each replica set member (not IP, especially in production).

## Testing

To run integration tests of this role

```
PLATFORM=ubuntu-1404     # OR ubuntu-1604, centos
kitchen verify $PLATFORM && kitchen destroy $PLATFORM
```

> **Note:**
>	`kitchen test` command is not appropriate for this role because both kitchen
>    suites (instances) need to be up and running for all tests to pass.


## ToDo:

- Sharding
- mongos
- authentication

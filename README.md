MongoDB
====

Ansible role to install and configure MongoDB.

Features:
- installs mongodb community edition
- updates mongodb config


> **WARNING:** 
>
>    Ensure you quote and lowercase any booleans. Unfortunately, mongodb
>    config options parser ONLY recognises "true" and "false" as boolean
>    values. Any other variation (e.g. True, False, etc) is seen as a
>    string and will result in parser failure on mongod start.
>
> (See: https://github.com/mongodb/mongo/blob/master/src/mongo/util/options_parser/options_parser.cpp)


## Example

```
  roles:
    - wunzeco.mongodb
```

## ToDo:

- Replica Set config

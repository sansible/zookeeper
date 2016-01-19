# Zookeeper

Master: ![Build Status](https://travis-ci.org/ansible-city/zookeeper.svg?branch=master)  
Develop: ![Build Status](https://travis-ci.org/ansible-city/zookeeper.svg?branch=develop)

* [ansible.cfg](#ansible-cfg)
* [Dependencies](#dependencies)
* [Tags](#tags)
* [Examples](#examples)

This roles installs Apache Zookeeper server.

For more information about Zookeeper please visit
[zookeeper.apache.org/](http://zookeeper.apache.org/).




## ansible.cfg

This role is designed to work with merge "hash_behaviour". Make sure your
ansible.cfg contains these settings

```INI
[defaults]
hash_behaviour = merge
```




## Dependencies

To install dependencies, add this to your roles.yml

```YAML
---

- name: ansible-city.zookeeper
  src: git+git@github.com:ansible-city/zookeeper.git
  version: origin/master # or any other tag/branch
```

and run `ansible-galaxy install -p . -r roles.yml`




## Tags

This role uses two tags: **build** and **configure**

* `build` - Installs Zookeeper server and all it's dependencies.
* `configure` - Configure and ensures that the Zookeeper service is running.




## Examples

```YAML
- name: Install Zookeeper Server
  hosts: sandbox

  pre_tasks:
    - name: Update apt
      become: yes
      apt:
        cache_valid_time: 1800
        update_cache: yes
      tags:
        - build

  roles:
    - name: ansible-city.zookeeper
```

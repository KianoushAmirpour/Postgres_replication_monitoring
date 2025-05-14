## Project description
This project showcases the setup of a PostgreSQL cluster configured with master-slave streaming replication. It features a monitoring and alerting system using `Prometheus, Grafana, PostgreSQL Exporter, Node Exporter and Alertmanager` to maintain high performance and enable proactive issue detection.  
  
Two deployment approaches are supported:  
* Docker Compose.
* Ansible across three separate Ubuntu 22.04 nodes:
  * A primary database node
  * A replica database node
  * A dedicated monitoring node  

## Docker-compose structure

![436928988-d775297b-6289-4cdf-98f8-68cbd03d0d3e](https://github.com/user-attachments/assets/45c42b62-8508-4a77-875d-7105b5e5843b)

### How to use:
create a .env and specify your passwords:
```
PG_MASTER_PASS=
PG_REPLICA_PASS=
GF_SECURITY_ADMIN_PASSWORD=
```
You also need to fill the [alertmanager config file](https://github.com/KianoushAmirpour/Postgres_replication_monitoring/blob/main/config_files/alertmanager/config.yaml) with your personal data.

Run `docker-compose up`.

## Ansible Structure
```
├── ansible.cfg
├── inventory
│   ├── group_vars
│   │   ├── all.yml
│   │   └── postgres_servers.yml
│   ├── host_vars
│   │   ├── pg_primary.yml
│   │   ├── pg_replica_01.yml
│   │   └── prometheus_grafana.yml
│   └── main.yml
├── log
│   └── ansible.log
├── playbooks
│   └── main.yml
├── roles
│   ├── common
│   │   └── tasks
│   │       └── main.yml
│   ├── grafana
│   │   ├── files
│   │   │   └── tmp
│   │   │       └── gpg.key
│   │   └── tasks
│   │       └── main.yml
│   ├── node_exporter
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── templates
│   │       └── node_exporter.service.j2
│   ├── postgres_exporter
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── templates
│   │       └── postgres_exporter.service.j2
│   ├── postgresql
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── templates
│   │       └── postgresql.conf.j2
│   └── prometheus
│       ├── tasks
│       │   └── main.yml
│       └── templates
│           ├── prometheus.service.j2
│           └── prometheus.yml.j2
```
### How to use:  
Configure youre IP addresses [here](https://github.com/KianoushAmirpour/Postgres_replication_monitoring/blob/main/postgresql_replication_ansible/inventory/group_vars/all.yml)  
For sake of simplicity, the postgresql passwords have been set to 123456. You can change it [here](https://github.com/KianoushAmirpour/Postgres_replication_monitoring/blob/main/postgresql_replication_ansible/inventory/group_vars/postgres_servers.yml)  
to run the playbook:  
```
cd postgresql_replication_ansible  
ansible-playbook playbooks/main.yml
```

### Services:  
prometheues: http://{your ip address}:9090  
Grafana: http://{your ip address}:3000  
postgres_exporter: http://{your ip address}:9187/9188

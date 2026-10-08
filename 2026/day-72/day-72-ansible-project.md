# Day 72 -- Ansible Project: Automate Docker and Nginx Deployment

## Project Goal

This project combines the Ansible concepts from the previous days into
one complete deployment.

The automation:

-   Applies common server configuration.
-   Installs and starts Docker on the web server.
-   Logs in to Docker Hub using credentials protected by Ansible Vault.
-   Pulls and runs an Nginx Docker container.
-   Maps host port `8080` to container port `80`.
-   Installs Nginx on the EC2 host.
-   Configures host Nginx as a reverse proxy.
-   Sends traffic from host port `80` to the Docker application on port
    `8080`.
-   Uses Ansible roles, variables, templates, handlers, tags, and Vault.

## Architecture

``` text
Ansible Control Node
        |
        | SSH
        v
Web EC2 Server
+------------------------------------+
|                                    |
|  Host Nginx                        |
|  Port 80                           |
|       |                            |
|       | reverse proxy              |
|       v                            |
|  127.0.0.1:8080                   |
|       |                            |
|       v                            |
|  Docker Container: myapp           |
|  nginx:latest                      |
|  Container Port 80                 |
|                                    |
+------------------------------------+

Request flow:

Client -> Nginx :80 -> localhost:8080 -> Docker -> Container :80
```

## Project Directory Structure

``` text
ansible-docker-project/
├── ansible.cfg
├── inventory.ini
├── site.yml
├── group_vars/
│   ├── all.yml
│   └── web/
│       └── vault.yml
└── roles/
    ├── common/
    │   ├── defaults/
    │   ├── handlers/
    │   ├── tasks/
    │   │   └── main.yml
    │   └── templates/
    ├── docker/
    │   ├── defaults/
    │   │   └── main.yml
    │   ├── handlers/
    │   │   └── main.yml
    │   ├── tasks/
    │   │   └── main.yml
    │   └── templates/
    └── nginx/
        ├── defaults/
        │   └── main.yml
        ├── handlers/
        │   └── main.yml
        ├── tasks/
        │   └── main.yml
        └── templates/
            └── app-proxy.conf.j2
```

The role skeletons were created with:

``` bash
mkdir -p ansible-docker-project/roles
cd ansible-docker-project

ansible-galaxy init roles/common
ansible-galaxy init roles/docker
ansible-galaxy init roles/nginx
```

## Inventory

``` ini
[web]
web-server ansible_host=3.96.127.95

[app]
app-server ansible_host=16.52.169.142

[db]
db-server ansible_host=15.222.1.156

[all:vars]
ansible_user=ec2-user
ansible_ssh_private_key_file=~/.ssh/terra-server-key.pem

[application:children]
web
app

[all_servers:children]
application
db
```

> Note: Public IP addresses can change if EC2 instances are
> stopped/recreated. Update the inventory when required.

## Global Variables

File: `group_vars/all.yml`

``` yaml
---
timezone: America/Toronto
project_name: devops-app
app_env: development

common_packages:
  - vim
  - wget
  - git
  - htop
  - tree
  - jq
  - unzip
```

### Environment Note

The lab servers use Amazon Linux 2023. The full `curl` package was not
added because the system already had `curl-minimal`, which caused a DNF
package conflict when attempting to install full `curl`.

## Common Role

File: `roles/common/tasks/main.yml`

``` yaml
---
- name: Update package cache
  yum:
    update_cache: true
  tags: common

- name: Install common packages
  yum:
    name: "{{ common_packages }}"
    state: present
  tags: common

- name: Set hostname
  hostname:
    name: "{{ inventory_hostname }}"
  tags: common

- name: Set timezone
  timezone:
    name: "{{ timezone }}"
  tags: common

- name: Create deploy user
  user:
    name: deploy
    groups: wheel
    shell: /bin/bash
    state: present
  tags: common
```

The common role runs against all managed servers.

A second run returned `changed=0`, showing that the role is idempotent.

## Docker Role

### Docker Defaults

File: `roles/docker/defaults/main.yml`

``` yaml
---
docker_app_image: nginx
docker_app_tag: latest
docker_app_name: myapp
docker_app_port: 8080
docker_container_port: 80
```

The port mapping means:

``` text
EC2 host port 8080 -> Docker container port 80
```

### Docker Tasks

File: `roles/docker/tasks/main.yml`

``` yaml
---
- name: Install Docker
  dnf:
    name: docker
    state: present
  tags: docker

- name: Start and enable Docker
  service:
    name: docker
    state: started
    enabled: true
  tags: docker

- name: Add deploy user to docker group
  user:
    name: deploy
    groups: docker
    append: true
  tags: docker

- name: Log in to Docker Hub
  community.docker.docker_login:
    username: "{{ vault_docker_username }}"
    password: "{{ vault_docker_password }}"
  become_user: deploy
  when: vault_docker_username is defined
  no_log: true
  tags: docker

- name: Pull application image
  community.docker.docker_image:
    name: "{{ docker_app_image }}"
    tag: "{{ docker_app_tag }}"
    source: pull
  tags: docker

- name: Run application container
  community.docker.docker_container:
    name: "{{ docker_app_name }}"
    image: "{{ docker_app_image }}:{{ docker_app_tag }}"
    state: started
    restart_policy: always
    ports:
      - "{{ docker_app_port }}:{{ docker_container_port }}"
  tags: docker

- name: Wait for container to respond
  uri:
    url: "http://localhost:{{ docker_app_port }}"
    status_code: 200
  register: health_check
  until: health_check.status == 200
  retries: 5
  delay: 3
  tags: docker
```

### Amazon Linux 2023 Adaptation

The project source describes installing Docker CE using the Docker CE
repository. For this lab, the managed nodes are Amazon Linux 2023, so
the native `docker` package was installed with `dnf`.

This was an environment-specific adaptation.

### Docker Handler

File: `roles/docker/handlers/main.yml`

``` yaml
---
- name: Restart Docker
  service:
    name: docker
    state: restarted
```

### Docker Collection

The Docker collection was checked with:

``` bash
ansible-galaxy collection install community.docker
```

It was already installed.

## Nginx Role

### Nginx Defaults

File: `roles/nginx/defaults/main.yml`

``` yaml
---
nginx_http_port: 80
nginx_upstream_port: 8080
nginx_server_name: "_"
```

Meaning:

``` text
nginx_http_port: 80       -> clients connect here
nginx_upstream_port: 8080 -> Docker application is here
nginx_server_name: "_"    -> catch-all server name
```

### Reverse Proxy Jinja2 Template

File: `roles/nginx/templates/app-proxy.conf.j2`

``` nginx
upstream app_backend {
    server 127.0.0.1:{{ nginx_upstream_port }};
}

server {
    listen {{ nginx_http_port }};
    server_name {{ nginx_server_name }};

    location / {
        proxy_pass http://app_backend;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /health {
        proxy_pass http://app_backend;
    }
}
```

Jinja2 changes:

``` text
{{ nginx_http_port }}     -> 80
{{ nginx_upstream_port }} -> 8080
{{ nginx_server_name }}   -> _
```

The rendered Nginx configuration therefore sends incoming port 80
traffic to `127.0.0.1:8080`.

### Nginx Tasks

File: `roles/nginx/tasks/main.yml`

``` yaml
---
- name: Install Nginx
  dnf:
    name: nginx
    state: present
  tags: nginx

- name: Deploy reverse proxy configuration
  template:
    src: app-proxy.conf.j2
    dest: /etc/nginx/conf.d/app-proxy.conf
    owner: root
    group: root
    mode: '0644'
  notify: Reload Nginx
  tags: nginx

- name: Test Nginx configuration
  command: nginx -t
  changed_when: false
  tags: nginx

- name: Start and enable Nginx
  service:
    name: nginx
    state: started
    enabled: true
  tags: nginx
```

### Nginx Handlers

File: `roles/nginx/handlers/main.yml`

``` yaml
---
- name: Reload Nginx
  service:
    name: nginx
    state: reloaded

- name: Restart Nginx
  service:
    name: nginx
    state: restarted
```

When the Jinja2 configuration changes, the template task notifies the
`Reload Nginx` handler.

This avoids unnecessary reloads when the configuration has not changed.

## Master Playbook

File: `site.yml`

``` yaml
---
- name: Apply common configuration
  hosts: all
  become: true

  roles:
    - common

  tags: common

- name: Install Docker and run containers
  hosts: web
  become: true

  roles:
    - docker

  tags: docker

- name: Configure Nginx reverse proxy
  hosts: web
  become: true

  roles:
    - nginx

  tags: nginx
```

The master playbook gives one entry point for the complete deployment.

## Ansible Vault

A Vault password file was stored in the Linux home directory:

``` text
~/.vault_pass
```

Permissions were restricted:

``` bash
chmod 600 ~/.vault_pass
```

The encrypted variables file is:

``` text
group_vars/web/vault.yml
```

It was created with:

``` bash
ansible-vault create group_vars/web/vault.yml \
  --vault-password-file ~/.vault_pass
```

The encrypted file begins with:

``` text
$ANSIBLE_VAULT;1.1;AES256
```

The plaintext structure before encryption contains variables like:

``` yaml
vault_docker_username: "<Docker Hub username>"
vault_docker_password: "<Docker Hub access token>"
```

**Never commit the Vault password file or expose real credentials in
documentation.**

To edit the encrypted file:

``` bash
ansible-vault edit group_vars/web/vault.yml \
  --vault-password-file ~/.vault_pass
```

The Docker login task also uses:

``` yaml
no_log: true
```

This helps prevent sensitive task output from appearing in Ansible logs.

## WSL / Windows Mount Note

This project is located under:

``` text
/mnt/c/Users/asmas/OneDrive/Desktop/90DaysOfDevOps/2026/day-72/ansible-docker-project
```

Ansible reports:

``` text
Ansible is being run in a world writable directory...
ignoring it as an ansible.cfg source.
```

Because the local `ansible.cfg` is ignored in this environment, commands
explicitly specify the inventory and Vault password file:

``` bash
ansible-playbook -i inventory.ini site.yml \
  --vault-password-file ~/.vault_pass
```

The Vault password file was intentionally kept in the Linux home
directory instead of the Windows-mounted project directory.

## Using Tags

Tags allow only part of the project to run.

Run only the common role:

``` bash
ansible-playbook -i inventory.ini site.yml \
  --tags common \
  --vault-password-file ~/.vault_pass
```

Run only Docker:

``` bash
ansible-playbook -i inventory.ini site.yml \
  --tags docker \
  --vault-password-file ~/.vault_pass
```

Run only Nginx:

``` bash
ansible-playbook -i inventory.ini site.yml \
  --tags nginx \
  --vault-password-file ~/.vault_pass
```

This is useful when only one part of the server needs to be updated.

## Verification

### Docker Container

The container was verified with:

``` bash
ansible web -i inventory.ini -b -m command -a "docker ps"
```

The running container showed:

``` text
myapp
0.0.0.0:8080->80/tcp
```

This proves that host port `8080` maps to container port `80`.

### Direct Container Test

``` bash
ansible web -i inventory.ini \
  -m uri \
  -a "url=http://localhost:8080 status_code=200"
```

Result:

``` text
status: 200
msg: OK
```

### Nginx Reverse Proxy Test

``` bash
ansible web -i inventory.ini \
  -m uri \
  -a "url=http://localhost:80 status_code=200"
```

Result:

``` text
status: 200
msg: OK
```

This proves the complete path:

``` text
Port 80
  |
  v
Host Nginx
  |
  v
localhost:8080
  |
  v
Docker myapp
  |
  v
Container port 80
```

## Docker Hub + Vault Verification

The first login attempts failed because example credentials were still
stored in the Vault.

After editing the encrypted Vault with valid Docker Hub credentials, the
Docker deployment succeeded:

``` text
TASK [docker : Install Docker]                  ok
TASK [docker : Start and enable Docker]         ok
TASK [docker : Add deploy user to docker group] ok
TASK [docker : Log in to Docker Hub]            changed
TASK [docker : Pull application image]          ok
TASK [docker : Run application container]       ok
TASK [docker : Wait for container to respond]   ok

failed=0
```

This proves:

``` text
Encrypted Vault
      |
      v
Ansible decrypts credentials
      |
      v
Docker Hub login
      |
      v
Pull image
      |
      v
Run container
```

## Full Deployment

Run the complete project with:

``` bash
ansible-playbook -i inventory.ini site.yml \
  --vault-password-file ~/.vault_pass
```

This runs:

``` text
site.yml
 |
 +-- common role -> all servers
 |
 +-- docker role -> web server
 |
 +-- nginx role  -> web server
```

## Idempotency

Idempotency means:

> Run the same automation again and Ansible only changes something when
> a change is actually needed.

The common role was run twice. On the second run:

``` text
app-server : changed=0 failed=0
db-server  : changed=0 failed=0
web-server : changed=0 failed=0
```

The Docker role was also rerun after deployment. Existing Docker
installation, service state, image, container, and health check returned
`ok`.

For the final project proof, run the complete playbook twice:

``` bash
ansible-playbook -i inventory.ini site.yml \
  --vault-password-file ~/.vault_pass
```

Run the same command again and capture the second `PLAY RECAP`.

## Screenshots to Add Before Submission

Add your own terminal screenshots in this section before pushing the
final documentation.

### Screenshot 1 -- Full End-to-End Playbook

``` text
[ADD SCREENSHOT: ansible-playbook site.yml running successfully]
```

### Screenshot 2 -- Idempotency

``` text
[ADD SCREENSHOT: second complete run showing mostly/all ok]
```

### Screenshot 3 -- Docker Container

``` text
[ADD SCREENSHOT: docker ps showing myapp and 8080->80]
```

### Screenshot 4 -- Nginx Port 80 Test

``` text
[ADD SCREENSHOT: URI/curl test returning HTTP 200 through port 80]
```

## What I Learned

During Day 72 I combined the main Ansible concepts into one project:

-   **Inventory** tells Ansible which servers to manage.
-   **Playbooks** control the overall deployment.
-   **Roles** organize automation into reusable sections.
-   **Tasks** perform the actual work.
-   **Variables** keep values reusable and easy to change.
-   **Jinja2 templates** generate configuration dynamically.
-   **Handlers** reload or restart services only when needed.
-   **Tags** let me run only selected parts of the deployment.
-   **Ansible Vault** protects sensitive credentials.
-   **Docker modules** manage images and containers.
-   **Nginx** works as a reverse proxy in front of the container.
-   **Idempotency** means repeated runs do not make unnecessary changes.

## Final Result

The final architecture is:

``` text
Ansible
   |
   v
EC2 Web Server
   |
   +-- Host Nginx :80
   |       |
   |       +-- reverse proxy --> localhost:8080
   |
   +-- Docker
           |
           +-- myapp
               nginx:latest
               container :80
```

The application was successfully tested directly through Docker on port
`8080` and through the host Nginx reverse proxy on port `80`.

## Submission

Save this documentation at:

``` text
2026/day-72/day-72-ansible-project.md
```

Then commit and push it to the 90DaysOfDevOps repository after adding
the required screenshots.

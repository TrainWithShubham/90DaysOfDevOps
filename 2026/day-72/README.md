# Day 72 -- Ansible Project: Automate Docker and Nginx Deployment

## Task
Five days of Ansible -- inventory, ad-hoc commands, playbooks, modules, handlers, variables, facts, conditionals, loops, roles, templates, Galaxy, and Vault. Today you put it all together and build what you would actually do on the job.

Automate a complete deployment: install Docker, pull and run a containerized application, set up Nginx as a reverse proxy in front of it, and manage everything through Ansible roles. One command to go from a fresh server to a fully running, production-style setup.

---

## Expected Output
- A complete Ansible project with custom roles for Docker and Nginx
- Docker containers running on managed nodes, deployed entirely through Ansible
- Nginx configured as a reverse proxy to the container
- Vault-encrypted Docker Hub credentials
- A markdown file: `day-72-ansible-project.md`
- A running app accessible through Nginx on port 80

---

## Challenge Tasks

### Task 1: Plan the Project Structure
Create the complete project layout:

```
ansible-docker-project/
  ansible.cfg
  inventory.ini
  site.yml                          # Master playbook
  group_vars/
    all.yml                         # Common variables
    web/
      vars.yml                      # Nginx variables
      vault.yml                     # Encrypted Docker Hub credentials
  roles/
    common/                         # Shared setup for all servers
      tasks/main.yml
    docker/                         # Docker installation and container management
      tasks/main.yml
      templates/
        docker-compose.yml.j2
      handlers/main.yml
      defaults/main.yml
    nginx/                          # Nginx reverse proxy
      tasks/main.yml
      templates/
        nginx.conf.j2
        app-proxy.conf.j2
      handlers/main.yml
      defaults/main.yml
```

Generate the role skeletons:
```bash
mkdir -p ansible-docker-project/roles
cd ansible-docker-project
ansible-galaxy init roles/common
ansible-galaxy init roles/docker
ansible-galaxy init roles/nginx
```

Set up your `ansible.cfg` and `inventory.ini` using what you built on Day 68.

---

### Task 2: Build the Common Role
The `common` role runs on every server -- baseline packages and setup.

**`roles/common/tasks/main.yml`:**
```yaml
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

(Use `apt` instead of `yum` if your instances run Ubuntu)

**`group_vars/all.yml`:**
```yaml
---
timezone: Asia/Kolkata
project_name: devops-app
app_env: development
common_packages:
  - vim
  - curl
  - wget
  - git
  - htop
  - tree
  - jq
  - unzip
```

---

### Task 3: Build the Docker Role
This role installs Docker, starts the service, pulls images, and runs containers.

**`roles/docker/defaults/main.yml`:**
```yaml
---
docker_app_image: nginx
docker_app_tag: latest
docker_app_name: myapp
docker_app_port: 8080
docker_container_port: 80
```

**`roles/docker/tasks/main.yml`:**
Write tasks that:
1. Install Docker dependencies (`yum-utils`, `device-mapper-persistent-data`, `lvm2`)
2. Add the Docker CE repository
3. Install Docker CE
4. Start and enable the Docker service
5. Add the `deploy` user to the `docker` group
6. Install Docker Compose (via pip or direct download)
7. Log in to Docker Hub using vault-encrypted credentials:
```yaml
- name: Log in to Docker Hub
  community.docker.docker_login:
    username: "{{ vault_docker_username }}"
    password: "{{ vault_docker_password }}"
  become_user: deploy
  when: vault_docker_username is defined
```
8. Pull the application image:
```yaml
- name: Pull application image
  community.docker.docker_image:
    name: "{{ docker_app_image }}"
    tag: "{{ docker_app_tag }}"
    source: pull
```
9. Run the container:
```yaml
- name: Run application container
  community.docker.docker_container:
    name: "{{ docker_app_name }}"
    image: "{{ docker_app_image }}:{{ docker_app_tag }}"
    state: started
    restart_policy: always
    ports:
      - "{{ docker_app_port }}:{{ docker_container_port }}"
```
10. Verify the container is running:
```yaml
- name: Wait for container to be healthy
  uri:
    url: "http://localhost:{{ docker_app_port }}"
    status_code: 200
  retries: 5
  delay: 3
  register: health_check
  until: health_check.status == 200
```

Tag all tasks with `docker`.

**`roles/docker/handlers/main.yml`:**
```yaml
---
- name: Restart Docker
  service:
    name: docker
    state: restarted
```

**Install the required Ansible collection** (needed for `community.docker` modules):
```bash
ansible-galaxy collection install community.docker
```

---

### Task 4: Build the Nginx Role
This role installs Nginx and configures it as a reverse proxy to the Docker container.

**`roles/nginx/defaults/main.yml`:**
```yaml
---
nginx_http_port: 80
nginx_upstream_port: 8080
nginx_server_name: "_"
```

**`roles/nginx/tasks/main.yml`:**
Write tasks that:
1. Install Nginx
2. Remove the default Nginx site config
3. Deploy the main Nginx config from a template
4. Deploy the reverse proxy config from a template
5. Test Nginx config before reloading:
```yaml
- name: Test Nginx configuration
  command: nginx -t
  changed_when: false
```
6. Start and enable Nginx
7. Use a handler to reload Nginx when any config changes

Tag all tasks with `nginx`.

**`roles/nginx/templates/app-proxy.conf.j2`:**
```nginx
# Reverse Proxy to Docker Container -- Managed by Ansible
upstream docker_app {
    server 127.0.0.1:{{ nginx_upstream_port }};
}

server {
    listen {{ nginx_http_port }};
    server_name {{ nginx_server_name }};

    location / {
        proxy_pass http://docker_app;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /health {
        access_log off;
        return 200 'OK';
        add_header Content-Type text/plain;
    }

{% if app_env == 'production' %}
    access_log /var/log/nginx/{{ project_name }}_access.log;
    error_log /var/log/nginx/{{ project_name }}_error.log;
{% else %}
    access_log /var/log/nginx/{{ project_name }}_access.log;
    error_log /var/log/nginx/{{ project_name }}_error.log debug;
{% endif %}
}
```

**`roles/nginx/handlers/main.yml`:**
```yaml
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

---

### Task 5: Encrypt Docker Hub Credentials with Vault
1. Create the vault file:
```bash
ansible-vault create group_vars/web/vault.yml
```
Add:
```yaml
vault_docker_username: your-dockerhub-username
vault_docker_password: your-dockerhub-token
```

2. Create a vault password file for convenience:
```bash
echo "YourVaultPassword" > .vault_pass
chmod 600 .vault_pass
echo ".vault_pass" >> .gitignore
```

3. Reference it in `ansible.cfg`:
```ini
[defaults]
inventory = inventory.ini
host_key_checking = False
vault_password_file = .vault_pass
```

---

### Task 6: Write the Master Playbook and Deploy
**`site.yml`:**
```yaml
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

Deploy the full stack:
```bash
# Dry run first -- always
ansible-playbook site.yml --check --diff

# Full deploy
ansible-playbook site.yml
```

Use tags for selective execution:
```bash
# Only set up Docker and containers
ansible-playbook site.yml --tags docker

# Only update Nginx config
ansible-playbook site.yml --tags nginx

# Skip common setup
ansible-playbook site.yml --skip-tags common
```

**Verify:**
1. Curl the server on port 8080 -- does the Docker container respond directly?
2. Curl the server on port 80 -- does Nginx reverse proxy the request to the container?
3. Check `docker ps` on the server -- is the container running with the correct port mapping?

---

### Task 7: Bonus -- Deploy a Different App and Re-Run
Change the Docker image to something else. Update `group_vars/all.yml` or pass extra vars:

```bash
ansible-playbook site.yml --tags docker \
  -e "docker_app_image=httpd docker_app_tag=latest docker_app_name=apache-app"
```

The old container should be replaced with the new one. Nginx still proxies traffic -- no config change needed.

Now run the full playbook one more time:
```bash
ansible-playbook site.yml
```

The output should show mostly `ok` with zero or minimal `changed`. This proves your entire setup is **idempotent**.

**Reflect and document:**
1. How many total tasks ran?
2. Map each Ansible concept to the day you learned it:

| Day | Concept Used |
|-----|-------------|
| 68 | Inventory, ad-hoc commands, SSH setup |
| 69 | Playbooks, modules, handlers |
| 70 | Variables, facts, conditionals, loops |
| 71 | Roles, templates, Galaxy, Vault |
| 72 | Everything combined in one project |

3. What would you add for production? (SSL with certbot, monitoring, log rotation, multi-container Compose)
4. Clean up your EC2 instances when done. If you used Terraform: `terraform destroy`. If manual: terminate from the console.

---

## Hints
- Install `community.docker` collection before running: `ansible-galaxy collection install community.docker`
- If `community.docker` modules are not available, you can use `command` or `shell` with `docker run` as a fallback
- Nginx and the Docker container run on the same server -- Nginx listens on port 80, container on port 8080
- `nginx -t` tests the config without reloading -- always run this before a reload
- `restart_policy: always` ensures the container restarts after a server reboot
- Tags let you update just Docker containers or just Nginx config independently
- `--check --diff` is your best friend before any deployment
- If the container port conflicts with another service, change `docker_app_port` in defaults
- The `uri` module is a clean way to health-check without installing curl on the managed node

---

## Documentation
Create `day-72-ansible-project.md` with:
- Your complete project directory structure
- Key files: `site.yml`, each role's `tasks/main.yml`, the Nginx reverse proxy template
- Screenshot of `ansible-playbook site.yml` running end-to-end
- Screenshot proving idempotency (second run with all ok)
- Screenshot of `docker ps` on the server showing the running container
- Screenshot of curling port 80 through Nginx
- How you used tags for selective deployment
- How Vault protected Docker Hub credentials
- Architecture: Ansible -> Server [Nginx:80 -> Docker Container:8080]

---

## Submission
1. Add `day-72-ansible-project.md` to `2026/day-72/`
2. Commit and push to your fork

---

## Learn in Public
Share on LinkedIn: "Completed the Ansible block -- automated a full Docker + Nginx deployment with custom roles. Docker installed, container running, Nginx reverse-proxying, secrets encrypted with Vault. One command sets up the entire server. Five days from zero to production-grade automation."

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**

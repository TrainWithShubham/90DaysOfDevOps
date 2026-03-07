## What are the two ways to write a list in YAML?
 ### There are two ways write list in yaml
1. Devops_course:
       - Linux
       - GIT
       - Docker
2. Devops_cours: [Linux, git, Docker]

## Write in your notes: When would you use | vs >?

    startup_script_literal: |
    echo "Starting application"
    docker pull myapp:latest
    docker compose up -d
    echo "Deployment complete"

    
    
#### It keeps the formatting exactly as written:
✅ Use | (Literal Style) When:

Writing shell scripts

Multi-line commands

Kubernetes container commands

GitHub Actions run: blocks

Docker Compose commands

Anything where line breaks matter

startup_script_literal: |
    echo "Starting application"
    docker pull myapp:latest
    docker compose up -d
    echo "Deployment complete"

    ✅ Use > (Folded Style) When:

Writing long messages

Descriptions

Commit messages

Notifications (Slack, email)

When formatting doesn't matter




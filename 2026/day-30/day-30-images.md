# Day 30 – Docker Images & Container Lifecycle
---
## Task 1: Docker Images

Compare ubuntu vs alpine — why is one much smaller?
- Ubuntu vs Alpine (why size difference?)
- Ubuntu (~70MB): full GNU userland, glibc, package manager, more utilities
- Alpine (~7MB): minimal distro using musl libc + BusyBox
- Alpine is smaller because it strips down:
- fewer binaries
- lighter libc (musl vs glibc)
- minimal dependencies

Tradeoff: Alpine can have compatibility issues with some software expecting glibc.

----

- Inspect an image — what information can you see?

Key fields to look at:

- Id → image hash
- RepoTags
- Created
- Architecture
- OS
- Layers
- Config (env vars, default command)

----

## Task 2: Image Layers

Notes (conceptual answer)

What are layers?

- Immutable filesystem diffs stacked to build an image

Why Docker uses them:

- Caching → faster builds
- Reusability → shared layers across images
- Efficiency → only changed layers are rebuilt/transferred

----

## Task 3: Container Lifecycle

States you'll see:

- created
- running
- paused
- exited

-----
## Task 4: Working with Running Containers

----
## Task 5: Cleanup

----
![alt text](docker-installed-network-images-volumes-ps.png) ![alt text](day30-task-1.png) ![alt text](day30-task-1-img-ins-alpine.png) ![alt text](day30-task-1-img-ins-ubuntu.png) ![alt text](day30-task-1-inspect.png) ![alt text](day30-task-1-insp-nginx.png) ![alt text](day30-task-1-rmi.png) ![alt text](day30-task-2-nginx.png) ![alt text](day30-task-2-ubuntu-alpine-history.png) ![alt text](day30-task-3.png) ![alt text](day30-task-3-kill.png) ![alt text](day30-task-4.png) ![alt text](day30-task-4-f-log.png) ![alt text](day30-task-4-ng-ins.png) ![alt text](day30-task-4-ng-ins-2.png) ![alt text](day30-task-4-ng-ins-3.png) ![alt text](day30-task-4-ng-ins-4.png) ![alt text](day30-task-4-ng-ins-5.png) ![alt text](day30-task-4-ng-ins-6.png) ![alt text](day30-task-4-nginx.png) ![alt text](day30-task-5.png)




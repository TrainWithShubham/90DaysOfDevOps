1. When would you use CMD vs ENTRYPOINT?

A. CMD mentioned in Dockerfile can be overidden by custom command given while running the docker container whereas ENTRYPOINT arguments mentioned in the file cannot be overidden and will execute along with custom command passed

2. Why does layer order matter for build process?

- Docker uses a build cache to speed up image creation process. When building an image docker checks if it has an existing layer that matches the instruction and its context.
- If the layer order changes docker considers it as a new instrution and builds it from scratch.
- By placing the more stable and less frequently changing instructions at the beginning optimizes the image and uses cache to build which speeds up the process. 
# Day 23 Task: Jenkins Freestyle Project for DevOps Engineers

The community is absolutely crushing it in the #90daysofdevops journey. Today's challenge is particularly exciting as it involves creating a Jenkins Freestyle Project, an excellent opportunity for DevOps engineers to showcase their skills and push their limits. Who's ready to dive in and make it happen? 😍

## What is CI/CD?

- **CI (Continuous Integration)** is the practice of automating the integration of code changes from multiple developers into a single codebase. It involves developers frequently committing their work into a central code repository (such as GitHub or Stash). Automated tools then build the newly committed code and perform tasks like code review, ensuring that the code is integrated smoothly. The key goals of Continuous Integration are to find and address bugs quickly, make the integration process easier across a team of developers, improve software quality, and reduce the time it takes to release new features.

- **CD (Continuous Delivery)** follows Continuous Integration and ensures that new changes can be released to customers quickly and without errors. This includes running integration and regression tests in a staging environment (similar to production) to ensure the final release is stable. Continuous Delivery automates the release process, ensuring a release-ready product at all times and allowing deployment at any moment.

## What Is a Build Job?

A Jenkins build job contains the configuration for automating specific tasks or steps in the application building process. These tasks include gathering dependencies, compiling, archiving, transforming code, testing, and deploying code in different environments.

Jenkins supports several types of build jobs, such as freestyle projects, pipelines, multi-configuration projects, folders, multibranch pipelines, and organization folders.

## What is a Freestyle Project? 🤔

A freestyle project in Jenkins is a type of project that allows you to build, test, and deploy software using various options and configurations. Here are a few tasks you could complete with a freestyle project in Jenkins:

### Task 1

- Create an agent for your app (which you deployed using Docker in a previous task).
- Create a new Jenkins freestyle project for your app.
- In the "Build" section of the project, add a build step to run the `docker build` command to build the image for the container.
- Add a second step to run the `docker run` command to start a container using the image created in the previous step.

### Task 2

- Create a Jenkins project to run the `docker-compose up -d` command to start multiple containers defined in the compose file (Hint: use the application and database docker-compose file from Day 19).
- Set up a cleanup step in the Jenkins project to run the `docker-compose down` command to stop and remove the containers defined in the compose file.

For reference on Jenkins Freestyle Projects, visit [here](https://youtu.be/wwNWgG5htxs).

You can post on LinkedIn and let us know what you have learned from this task as part of the #90DaysOfDevOps Challenge.

**Happy Learning :)**

[← Previous Day](../day22/README.md) | [Next Day →](../day24/README.md)

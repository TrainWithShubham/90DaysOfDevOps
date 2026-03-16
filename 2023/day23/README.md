# Day 23 Task: Jenkins Freestyle Project for DevOps Engineers.

The Community is absolutely crushing it in the #90daysofdevops journey. Today's challenge is particularly exciting as it entails creating a Jenkins Freestyle Project, an opportunity for DevOps engineers to showcase their skills and push their limits. Who's ready to dive in and make it happen? 😍

## What is CI/CD?

- CI or Continuous Integration is the practice of automating the integration of code changes from multiple developers into a single codebase. It is a software development practice where the developers commit their work frequently into the central code repository (Github or Stash). Then there are automated tools that build the newly committed code and do a code review, etc as required upon integration.
  The key goals of Continuous Integration are to find and address bugs quicker, make the process of integrating code across a team of developers easier, improve software quality and reduce the time it takes to release new feature updates.

- CD or Continuous Delivery is carried out after Continuous Integration to make sure that we can release new changes to our customers quickly in an error-free way. This includes running integration and regression tests in the staging area (similar to the production environment) so that the final release is not broken in production. It ensures to automate the release process so that we have a release-ready product at all times and we can deploy our application at any point in time.

## What Is a Build Job?

A Jenkins build job contains the configuration for automating a specific task or step in the application building process. These tasks include gathering dependencies, compiling, archiving, or transforming code, and testing and deploying code in different environments.

Jenkins supports several types of build jobs, such as freestyle projects, pipelines, multi-configuration projects, folders, multibranch pipelines, and organization folders.

## What is Freestyle Projects ?? 🤔

A freestyle project in Jenkins is a type of project that allows you to build, test, and deploy software using a variety of different options and configurations. Here are a few tasks that you could complete when working with a freestyle project in Jenkins:

# Task-01

- create a agent for your app. ( which you deployed from docker in earlier task)
- Create a new Jenkins freestyle project for your app.
- In the "Build" section of the project, add a build step to run the "docker build" command to build the image for the container.
- Add a second step to run the "docker run" command to start a container using the image created in step 3.

# Task-02

- Create Jenkins project to run "docker-compose up -d" command to start the multiple containers defined in the compose file (Hint- use day-19 Application & Database docker-compose file)
- Set up a cleanup step in the Jenkins project to run "docker-compose down" command to stop and remove the containers defined in the compose file.

For Refference jenkins Freestyle Project visit [here](https://youtu.be/wwNWgG5htxs)

You can Post on LinkedIn and let us know what you have learned from this task by #90DaysOfDevOps Challenge.

Happy Learning:)

[← Previous Day](../day22/README.md) | [Next Day →](../day24/README.md)

# Day 39 AWS and IAM Basics☁

![AWS](https://miro.medium.com/max/1400/0*dIzXLQn6aBClm1TJ.png)

By this time you have created multiple EC2 instances, and post installation manually installed applications like Jenkins, docker etc.
Now let's switch to little automation part. Sounds interesting??🤯

## AWS:

Amazon Web Services is one of the most popular Cloud Provider that has free tier too for students and Cloud enthutiasts for their Handson while learning (Create your free account today to explore more on it).

Read from [here](https://aws.amazon.com/what-is-aws/)

## User Data in AWS:

- When you launch an instance in Amazon EC2, you have the option of passing user data to the instance that can be used to perform common automated configuration tasks and even run scripts after the instance starts. You can pass two types of user data to Amazon EC2: shell scripts and cloud-init directives.
- You can also pass this data into the launch instance wizard as plain text, as a file (this is useful for launching instances using the command line tools), or as base64-encoded text (for API calls).
- This will save time and manual effort everytime you launch an instance and want to install any application on it like apache, docker, Jenkins etc

Read more from [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)

## IAM:

AWS Identity and Access Management (IAM) is a web service that helps you securely control access to AWS resources. With IAM, you can centrally manage permissions that control which AWS resources users can access. You use IAM to control who is authenticated (signed in) and authorized (has permissions) to use resources.
Read from [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)

Get to know IAM more deeply🏊[Click Here!!](https://www.youtube.com/watch?v=ORB4eY8EydA)

### Task1:

- Launch EC2 instance with already installed Jenkins on it. Once server shows up in console, hit the IP address in browser and you Jenkins page should be visible.
- Take screenshot of Userdata and Jenkins page, this will verify the task completion.

### Task2:

- Read more on IAM Roles and explain the IAM Users, Groups and Roles in your own terms.
- Create three Roles named: DevOps-User, Test-User and Admin.

Post your progress on Linkedin. Till then Happy Learning :)

[← Previous Day](../day38/README.md) | [Next Day →](../day40/README.md)

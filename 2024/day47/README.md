# Day 47: AWS Elastic Beanstalk
Today, we explore the new AWS service- Elastic Beanstalk. We'll also cover deploying a small web application (game) on this platform

## What is AWS Elastic Beanstalk?
![image](https://github.com/Simbaa815/90DaysOfDevOps/assets/112085387/75f69087-d769-4586-b4a7-99a87feaec92)

- AWS Elastic Beanstalk is a service used to deploy and scale web applications developed by developers.
- It supports multiple programming languages and runtime environments such as Java, .NET, PHP, Node.js, Python, Ruby, Go, and Docker.

## Why do we need AWS Elastic Beanstalk?
- Previously, developers faced challenges in sharing software modules across geographically separated teams.
- AWS Elastic Beanstalk solves this problem by providing a service to easily share applications across different devices.

## Advantages of AWS Elastic Beanstalk
- Highly scalable
- Fast and simple to begin
- Quick deployment
- Supports multi-tenant architecture
- Simplifies operations
- Cost efficient

## Components of AWS Elastic Beanstalk
- Application Version: Represents a specific iteration or release of an application's codebase.
- Environment Tier: Defines the infrastructure resources allocated for an environment (e.g., web server environment, worker environment).
- Environment: Represents a collection of AWS resources running an application version.
- Configuration Template: Defines the settings for an environment, including instance types, scaling options, and more.

## Elastic Beanstalk Environment 
There are two types of environments: <b>web server</b> and <b>worker</b>.

- <u>Web server environments</u> are front-end facing, accessed directly by clients using a URL.

- <u>Worker environments</u> support backend applications or micro apps.

## Task-01
Deploy the [2048-game](https://github.com/Simbaa815/2048-game) using the AWS Elastic Beanstalk.

If you ever find yourself facing a challenge, feel free to refer to this helpful [blog](https://devxblog.hashnode.dev/aws-elastic-beanstalk-deploying-the-2048-game) post for guidance and support.

---

# Additional work 

## Test Knowledge on aws 💻 📈
Today, we will be test the aws knowledge on services in AWS, as part of the 90 Days of DevOps Challenge.


## Task-01

- Launch an EC2 instance using the AWS Management Console and connect to it using SSH.
- Install a web server on the EC2 instance and deploy a simple web application.
- Monitor the EC2 instance using Amazon CloudWatch and troubleshoot any issues that arise.

## Task-02
- Create an Auto Scaling group using the AWS Management Console and configure it to launch EC2 instances in response to changes in demand.
- Use Amazon CloudWatch to monitor the performance of the Auto Scaling group and the EC2 instances and troubleshoot any issues that arise.
- Use the AWS CLI to view the state of the Auto Scaling group and the EC2 instances and verify that the correct number of instances are running.


We hope that these tasks will give you hands-on experience with aws services and help you understand how these services work together. If you have any questions or face any issues while doing the tasks, please let us know.

Happy Learning :)

[← Previous Day](../day46/README.md) | [Next Day →](../day48/README.md)

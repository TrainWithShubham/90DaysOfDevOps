## what is Container?
Container is light weight, standalone and executable software packages that includes everything need to run an aplication
like  code, runtime, system tools, libraries, and settings. 
Container run on the host OS level of the system. It's share the available resouses of the system as per requirement.
A Conatainer is runing instance of docker image.
#### Why we need  conatainer?
# 1. Environment Consistency
 Same App run on the different ways: 
1. Local
2. EC2 instace
3. Kubernetes
4. Cloud
    No Environment Mismatch
# 2. Isolation 
Container isolates the application 
Example:
. App1 needs Python 3.8
 .Apps2 needs python 3.11
  They Won't conflict
  # 3. Lightweight (Important Difference from VM)
  ** Containers share host OS kernel.
  ** Unlike virtual machine:
  ** . No Full OS inside 
  ** . Fatster Startup 
  ** . Less memory usage
  # 4. Faster Deployment 
  ** Start container in seconds where VMs takes minutes.
  # 5. Scalability
  ** We can multile conatainer at time. Used in microservices.
  # 6. Microservices Architecture
  Modern apps are built as:
  1.payment-services
  2.Auth services 
  3.Order services
  Each runs in it's own container.

Each runs in its own container.
  

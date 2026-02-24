# EC2-Security-Group-Guide
Step-by-step guide for how to create and configure Security Groups.

## **Step 1: Sign in to AWS Console** ##

1. Go to AWS Management Console.
2. Sign in to your credential.
3. Navigate to **EC2** under the **Commute**.

## **Step 2: launch an EC2 Instance** ##

1. click **Launch Instance**.
2. Create a Name tag for EC2 Instance.
3. Choose an Amazon Machine Image(**AMI**).
4. Select an **Instance Type**.
5. Create or Select already existing **Key** Pair.

## **Step 3: Configure Security Group** ## 
Security group defines who can access your instance.

1. Create New Security group
   
   • Enter **name** for Security group.
   
   • Write **description** for Security Group.
2. Add Inbound Rules(traffic coming to the instance)
   
   •**SSH(TCP 22)** - To connect via SSH.
   
   •**HTTP(TCP 80)** - To allow web traffic if hosting a website.
   
   •**HTTPS(TCP 443)** - To allow Secure web traffic.

3. Add Outbound Rules(traffic leaving the instance)
   
   •By default all outbound traffic is allowed, you can leave it as is.

## **Step 4: Configure storage** ##
1. You can configure storage for your instance as you need and by default **8GB** is selected.

## **Step 4: Review and launch** ##
1. Review all settings: **Instance Type, AMI, Security Group, etc.**
2. Check Acknowledgement box and click **launch instances**.

## **Step 5: Connect to your EC2 Instance** ##
1. Go to Instances in EC2 dashboard.
2. Select the instance and click **Connect**.
3. And Follow the SSH instructions.



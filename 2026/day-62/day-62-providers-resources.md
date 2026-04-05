# Day 62 -- Providers, Resources and Dependencies


## Task 1: Explore the AWS Provider
Ans: .terraform.lock.hcl showes the exact version which  taken in the project.
What does ~> 5.0 mean? How is it different from >= 5.0 and = 5.0.0?
Ans: ~>5.0 means this pessimistic constants its mean it will provive 5.xx any version from 5.0 to 5.xxxx but not 6

## Task 2: Build a VPC from Scratch
<img width="1059" height="403" alt="image" src="https://github.com/user-attachments/assets/757d166e-b625-4335-9c91-167619c41590" />

## Task 3: Understand Implicit Dependencies
1. How does Terraform know to create the VPC before the subnet?
  Ans: To create a subnet required a valid vpc id otherwise it will throw erreor like ``A managed resource "aws_vpc" "main1" has not been declared in the root module.``  
2. What would happen if you tried to create the subnet before the VPC existed?
   Ans: It will throw  error
4. Find all implicit dependencies in your config and list them
   Ans:  
    "aws_internet_gateway.gw" [label="aws_internet_gateway.gw"];
  "aws_main_route_table_association.a" [label="aws_main_route_table_association.a"];
  "aws_route_table.router" [label="aws_route_table.router"];
  "aws_subnet.main" [label="aws_subnet.main"];
  "aws_vpc.main" [label="aws_vpc.main"];
  "aws_internet_gateway.gw" -> "aws_vpc.main";
  "aws_main_route_table_association.a" -> "aws_route_table.router";
  "aws_route_table.router" -> "aws_internet_gateway.gw";


## Task 4: Add a Security Group and EC2 Instance

verified

<img width="1546" height="714" alt="image" src="https://github.com/user-attachments/assets/a60882d6-bfba-4b0e-ba09-b2caf64df827" />


## Task 5: Explicit Dependencies with depends_on

<img width="1481" height="737" alt="image" src="https://github.com/user-attachments/assets/cc46c77a-f653-413e-a8da-99dca953510c" />
- There is a hidden / indirect dependency
- Order matters but no attribute is referenced
- You want to force creation/destruction order

in this case we will use explicit dependency.

What are the three lifecycle arguments (create_before_destroy, prevent_destroy, ignore_changes) and when would you use each?  

Ans:   create_before_destroy --->  Avoid downtime  
      prevent_destroy -->   Protect critical resources  
      ignore_changes --> Ignore specific updates

     








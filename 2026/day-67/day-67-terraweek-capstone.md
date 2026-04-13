Day 67: Multi-Environment Infrastructure with Workspaces and Modules

Here's what I built on the final day:

✅ 3 custom Terraform modules (VPC, Security Group, EC2)
✅ 3 isolated environments (dev, staging, prod) with Workspaces
✅ 21 AWS resources created and cleanly destroyed
✅ One codebase — zero console clicks

Key things I learned this week:

𝟭. Workspaces = same code, separate state per environment
𝟮. Modules = reusable infrastructure building blocks
𝟯. dynamic blocks = loops inside HCL for flexible rules
𝟰. data blocks call AWS APIs, locals compute values — never mix them
𝟱. Always plan before apply. Always destroy when done.

The biggest mindset shift: infrastructure is just code.
Version controlled. Reviewed. Reused. Destroyed cleanly.

From terraform init on Day 61 to a full multi-environment AWS project on Day 67 — one step at a time. 🚀

#90DaysOfDevOps #TerraWeek #Terraform #DevOps #IaC #AWS #DevOpsKaJosh #TrainWithShubham

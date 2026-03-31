# 🚀 Day 63 – Variables, Outputs, Data Sources & Expressions

---

# 📌 Overview

Day 63 focuses on transforming a **hardcoded Terraform configuration** into a **dynamic, reusable, and environment-aware setup**.

Goal:
- Remove hardcoding ❌
- Introduce flexibility ✅
- Support multiple environments (dev/prod) ✅

---

# 🧠 Key Outcome

✔ Fully parameterized Terraform config  
✔ Environment-based deployments  
✔ Dynamic AMI & AZ selection  
✔ Consistent tagging using locals  
✔ Outputs for visibility  

---

# 🧩 Task 1: Extract Variables

## 🔹 Variables Created

- region (string)
- vpc_cidr (string)
- subnet_cidr (string)
- instance_type (string)
- project_name (string, no default ❗)
- environment (string)
- allowed_ports (list(number))
- extra_tags (map(string))

---

## 🔹 Key Learning

- Variables remove hardcoding
- `project_name` without default → forces user input

---

## 🧠 Variable Types in Terraform

1. string  
2. number  
3. bool  
4. list  
5. map  

---

# 📁 Task 2: Variable Files & Precedence

## 🔹 terraform.tfvars (default)

~~~
project_name  = "terraweek"
environment   = "dev"
instance_type = "t2.micro"
~~~

---

## 🔹 prod.tfvars

~~~
project_name  = "terraweek"
environment   = "prod"
instance_type = "t3.small"
vpc_cidr      = "10.1.0.0/16"
subnet_cidr   = "10.1.1.0/24"
~~~

---

## 🔹 Commands

~~~
terraform plan
terraform plan -var-file="prod.tfvars"
terraform plan -var="instance_type=t2.nano"
~~~

---

## 🧠 Variable Precedence (Low → High)

1. default  
2. terraform.tfvars  
3. *.auto.tfvars  
4. -var-file  
5. -var  
6. TF_VAR_* (env variables)  

---

# 📤 Task 3: Outputs

## 🔹 Outputs Created

- vpc_id  
- subnet_id  
- instance_id  
- instance_public_ip  
- instance_public_dns  
- security_group_id  

---

## 🔹 Commands

~~~
terraform output
terraform output instance_public_ip
terraform output -json
~~~

---

## 🧠 Learning

- Outputs expose resource values
- Useful for debugging & automation

---

# 🔍 Task 4: Data Sources

## 🔹 AMI Data Source

- Fetch latest Amazon Linux 2 dynamically
- No hardcoding

---

## 🔹 AZ Data Source

- Fetch available AZs
- Use first AZ dynamically

---

## 🧠 Resource vs Data Source

| Resource | Data Source |
|---------|------------|
| Creates infra | Fetches existing data |
| Managed by Terraform | Read-only |
| Example: EC2 | Example: AMI |

---

# 🧠 Key Learning

✔ No region dependency  
✔ Always latest AMI  
✔ Portable infrastructure  

---

# 🏷️ Task 5: Locals (Dynamic Values)

## 🔹 Locals Block

~~~
locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
~~~

---

## 🔹 Usage

~~~
tags = merge(local.common_tags, {
  Name = "${local.name_prefix}-server"
})
~~~

---

## 🧠 Learning

✔ Centralized naming  
✔ Consistent tagging  
✔ Cleaner code  

---

# ⚙️ Task 6: Functions & Expressions

## 🔹 String Functions

~~~
upper("terraweek")
join("-", ["terra","week","2026"])
format("arn:aws:s3:::%s", "bucket")
~~~

---

## 🔹 Collection Functions

~~~
length(["a","b","c"])
lookup({dev="t2.micro"}, "dev")
toset(["a","b","a"])
~~~

---

## 🔹 Networking Function

~~~
cidrsubnet("10.0.0.0/16", 8, 1)
~~~

---

## 🔹 Conditional Expression

~~~
instance_type = var.environment == "prod" ? "t3.small" : "t2.micro"
~~~

---

## 🧠 Most Useful Functions

1. merge() → combine maps  
2. lookup() → get value from map  
3. length() → count elements  
4. join() → combine strings  
5. cidrsubnet() → subnet calculation  

---

# 💡 Key Learnings Summary

✔ Variables → dynamic configs  
✔ tfvars → environment separation  
✔ Outputs → visibility  
✔ Data sources → avoid hardcoding  
✔ Locals → reusable logic  
✔ Functions → powerful transformations  

---

# 🔥 Real-World Impact

Before:
- Hardcoded infra ❌
- Not reusable ❌

After:
- Dynamic infra ✅
- Multi-environment support ✅
- Production-ready Terraform ✅

---

# 🎯 Final Thought

This day marks the shift from:

👉 “Writing Terraform”  
➡️  
👉 “Designing reusable infrastructure”

---

# 🚀 Tags

#Terraform #DevOps #90DaysOfDevOps #TerraWeek #Cloud

# Terraform Modules Notes (Day 3)

## 1. What is a Terraform Module?
A Terraform module is a reusable, versionable, logical grouping of Terraform configuration files. Every Terraform configuration has at least one module (the root module in the working directory). When you create a folder with one or more `.tf` files and reference it with `module "name" { source = "path" }`, you are using a child module.

## 2. Why Use Modules?
Modules help you:
- **Re-use** infrastructure patterns (e.g., EC2 instance, VPC, S3 bucket) without rewriting code.
- **Standardize** conventions (naming, tagging, security rules) across teams.
- **Reduce duplication** and make updates easier (change once, propagate many places).
- **Encapsulate complexity** so consumers only pass variables and read outputs.
- **Enable composition** of larger architectures from small building blocks.
- **Improve testability** by isolating pieces of infra.
- **Enable versioning** when stored in separate repos or registries.

## 3. Module Structure (From Day3 Example)
Your Day3 folder contains a custom module at `modules/ec2_instance` with these files:
- `main.tf` – Declares the actual AWS resources (an `aws_instance`).
- `variables.tf` – Declares input variables the module expects (AMI, instance type, subnet ID).
- `outputs.tf` – Declares values the module exports (public IP address in this case).

Root module (`Day3/main.tf`) consumes it using:
```
module "ec2_instance" {
  source              = "./modules/ec2_instance"
  ami_value           = "ami-02d26659fd82cf299"
  instance_type_value = "t2.micro"
  subnet_id           = "subnet-0e6461471ef694c39"
}
```

Then it re-exports a module output:
```
output "ec2_public_ip" {
  value = module.ec2_instance.public-ip-address
}
```

## 4. Flow of Data
1. Root module passes input variables → module (`variables.tf`).
2. Module uses them inside `main.tf` to configure `aws_instance`.
3. Module exposes attributes via `outputs.tf`.
4. Root module can expose (forward) them again or consume internally.

## 5. Naming Conventions & Best Practices
- Use **kebab_case** or **snake_case** for variable and output names. Avoid hyphens in Terraform identifiers when possible because you must reference them as-is (hyphens can reduce readability). For example, prefer `public_ip_address` instead of `public-ip-address`.
- Always add **descriptions** to variables and outputs.
- Keep modules **minimal and focused** (single responsibility principle).
- Pass **tags** (if applicable) as a variable so environments can differentiate resources.
- Avoid embedding providers inside child modules unless you need different provider configurations. (In your module, you redeclare the `aws` provider; typically you'd let the root module configure the provider and just let the child inherit it.)

## 6. Improving the Current Module (Optional Enhancements)
Possible refinements:
- Remove the provider block from `modules/ec2_instance/main.tf` to inherit the root provider.
- Rename output `public-ip-address` → `public_ip` (and update references).
- Add variable `tags` (map(string)) and apply to the instance.
- Add an output for the `instance_id` and maybe `private_ip`.
- Add `version` constraints for the AWS provider in root.

Example improved module snippet:
```
# modules/ec2_instance/variables.tf
variable "ami_value" { description = "AMI ID for the EC2 instance" type = string }
variable "instance_type_value" { description = "Instance type" type = string }
variable "subnet_id" { description = "Subnet ID to launch into" type = string }
variable "tags" { description = "Tags to apply" type = map(string) default = {} }

# modules/ec2_instance/main.tf
resource "aws_instance" "example" {
  ami                    = var.ami_value
  instance_type          = var.instance_type_value
  subnet_id              = var.subnet_id
  tags                   = merge({ Name = "demo-ec2" }, var.tags)
}

# modules/ec2_instance/outputs.tf
output "public_ip"   { value = aws_instance.example.public_ip }
output "instance_id" { value = aws_instance.example.id }
```

Root usage:
```
module "ec2_instance" {
  source              = "./modules/ec2_instance"
  ami_value           = "ami-02d26659fd82cf299"
  instance_type_value = "t2.micro"
  subnet_id           = "subnet-0e6461471ef694c39"
  tags = { Environment = "dev" }
}

output "ec2_public_ip" { value = module.ec2_instance.public_ip }
```

## 7. When NOT to Use a Module
- One-off experiments or throwaway prototypes.
- Extremely simple single-resource definitions that won't be reused.
- When abstraction hides too much and causes confusion.

## 8. When to Start Extracting a Module
Look for signals:
- You copy-pasted a Terraform block 2+ times.
- You want a consistent tagging / naming policy.
- You need to share infra patterns across teams or repos.
- You want to publish reusable building blocks.

## 9. Module Sources
Modules can come from:
- Local paths (`./modules/ec2_instance`)
- Git repositories (`git::https://github.com/org/repo.git//path?ref=tag`)
- Terraform Registry (`terraform-aws-modules/vpc/aws`)
- Private registries (within your organization)

## 10. Debugging Module Issues
- Run `terraform init` after changing `source`.
- Use `terraform console` to inspect values (e.g., `module.ec2_instance.public-ip-address`).
- Use `terraform output` to list root outputs.
- If outputs not appearing: ensure root has an `output` block referencing the module output.

## 11. Key Takeaways (Day3 Context)
- You encapsulated an EC2 instance into a module for reuse.
- Root module supplies inputs and re-exports the public IP.
- Cleaning naming and inheritance (provider) will make it more idiomatic.
- This pattern scales as you add more infrastructure pieces.


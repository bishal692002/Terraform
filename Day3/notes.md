### 3. Input & Output Variables

Input Variables:

* Used to parameterize Terraform configurations.
* Declared with "variable" block.
* Attributes: description, type, default.

Example:

```
variable "example_var" {
  description = "An example input variable"
  type        = string
  default     = "default_value"
}

resource "example_resource" "example" {
  name = var.example_var
}
```

Output Variables:

* Used to expose values from a configuration or module.
* Useful for sharing values between modules or after apply.

Example:

```
output "example_output" {
  description = "An example output variable"
  value       = resource.example_resource.example.id
}
```

Reference module outputs:

```
output "root_output" {
  value = module.example_module.example_output
}
```

---

### 4. Variables Demo

```
# Input variable for instance type
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# Input variable for AMI
variable "ami_id" {
  description = "EC2 AMI ID"
  type        = string
}

# Provider
provider "aws" {
  region = "us-east-1"
}

# EC2 Instance
resource "aws_instance" "example_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
}

# Output variable
output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.example_instance.public_ip
}
```

---

### 5. Terraform .tfvars Files

Purpose:
Store values for input variables separately.

Useful for:

* Environment configs (dev, staging, prod).
* Sensitive values (keys, secrets).
* Collaboration (team-specific configs).

Example:

variables.tf

```
variable "instance_type" { type = string }
variable "ami_id" { type = string }
```

dev.tfvars

```
instance_type = "t3.micro"
ami_id        = "ami-0abcd1234efgh5678"
```

Run with:

```
terraform apply -var-file=dev.tfvars
```

---

### 6. Conditional Expressions

Syntax:

```
condition ? true_val : false_val
```

a) Conditional Resource Creation

```
resource "aws_instance" "example" {
  count         = var.create_instance ? 1 : 0
  ami           = "ami-xxxx"
  instance_type = "t2.micro"
}
```

b) Conditional Variable Assignment

```
variable "environment" {
  default = "development"
}

variable "production_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "development_subnet_cidr" {
  default = "10.0.2.0/24"
}

resource "aws_security_group" "example" {
  name = "example-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.environment == "production" ? 
                  [var.production_subnet_cidr] : 
                  [var.development_subnet_cidr]
  }
}
```

c) Conditional Resource Configuration

```
resource "aws_security_group" "example" {
  name = "example-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.enable_ssh ? ["0.0.0.0/0"] : []
  }
}
```



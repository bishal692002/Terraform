# Terraform Basic Workflow

## Commands Order

### 1. `terraform init`
Initializes the working directory and downloads required provider plugins.

### 2. `terraform plan`
Previews what Terraform will create, update, or destroy.  
Helps you verify before making changes.

### 3. `terraform apply`
Applies the changes and actually creates or updates resources.

### 4. `terraform destroy`
Destroys all resources defined in the configuration to clean up and avoid costs.

---

## Example Code

```hcl
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "this" {
  ami           = "ami-02d26659fd82cf299"
  instance_type = "t2.micro"
  key_name      = "your-existing-keypair-name"

  tags = {
    Name = "my-ec2-instance"
  }
}

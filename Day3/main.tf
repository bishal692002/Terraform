provider "aws" {
    region = "ap-south-1"
  
}
module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami_value = "ami-02d26659fd82cf299"
  instance_type_value = "t2.micro"
  subnet_id = "subnet-0e6461471ef694c39"
  
}

output "ec2_public_ip" {
  value = module.ec2_instance.public-ip-address
}

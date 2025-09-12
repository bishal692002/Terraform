variable "ami_value"{

    description = "value for the ami"
    
}


variable "instance_type_value"{
    description = "type of ec2 instance"
    type = string
}

variable "subnet_id"{
    description = "value of subnet id"

}

provider "aws"{
    region = "ap-south-1"
}


resource "aws_instance" "example"{
    ami = var.ami_value
    instance_type = var.instance_type_value
    subnet_id = var.subnet_id



}
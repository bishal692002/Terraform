provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
}

resource "aws_instance" "example1" {
  ami           = "ami-0866a3c8686eaeeba" 
  instance_type = "t2.micro"
  provider      = aws.us-east-1
}

resource "aws_instance" "example2" {
  ami           = "ami-0d53d72369335a9d6" 
  instance_type = "t2.micro"
  provider      = aws.us-west-1
}

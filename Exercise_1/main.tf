# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  access_key = "deleted"
  secret_key = "deleted"
  region = "us-east-1"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "UdacityT2" {
  ami = "ami-0ebfd941bbafe70c6"
  subnet_id = "subnet-0d489059fbbc87c87"
  instance_type = "t2.micro"
  count = 4
  tags = {
    Name = "Udacity T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
# resource "aws_instance" "UdacityM4" {
#   ami = "ami-0ebfd941bbafe70c6"
#   subnet_id = "subnet-0d489059fbbc87c87"
#   instance_type = "m4.large"
#   count = 2
#   tags = {
#     Name = "Udacity M4"
#   }
# }
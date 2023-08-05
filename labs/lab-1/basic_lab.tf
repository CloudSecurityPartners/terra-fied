provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "r2dso-lab_instance" {
  ami = "ami-0b69ea66ff7391e80" // Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"

get_password_data = true

  tags = {
    Name = "r2dso-lab-instance"
  }
}

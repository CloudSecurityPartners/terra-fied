provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "r2dso-lab_instance" {
  ami = "ami-0b69ea66ff7391e80" // Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"

  tags = {
    Name = "defcon-lab-instance"
  }
}


resource "aws_secretsmanager_secret" "example_secret" {
  name        = "example_secret"
  description = "This is an example secret"
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.example_secret.id
  secret_string = "my secret"
}
provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "test_instance" {
  ami = "ami-0b69ea66ff7391e80" // Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"

  tags = {
    Name = "defcon-lab-instance"
  }
}


resource "aws_secretsmanager_secret" "example_secret" {
  name        = lower(random_string.unique_id.id)
  description = "This is an example secret"
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.example_secret.id
  secret_string = "my secret"
}

resource "random_string" "unique_id" {
  length = 8
  special = false
}
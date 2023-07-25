module "network" {
  source = "./network"
}

resource "aws_instance" "r2dso-lab_instance" {
  ami = "ami-0b69ea66ff7391e80" // Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"
  key_name = var.key_name
  vpc_security_group_ids = [module.network.r2dso-lab-sg]
  subnet_id = module.network.r2dso-lab-subnet
  associate_public_ip_address = true

  tags = {
    Name = "r2dso-lab-instance"
  }
}

output "r2dso-lab-pub-ip" {
  value = aws_instance.r2dso-lab_instance.public_ip
}
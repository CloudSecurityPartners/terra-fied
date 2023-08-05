provider "aws" {
  region = "us-east-1"
}

resource "null_resource" "secrets_list" {
  provisioner "local-exec" {
    command = "aws secretsmanager list-secrets --region ${self.provider.region} --query 'SecretList[*].[Name]' --output json > secrets.json"
  }
  triggers = {
    always_run = timestamp()
  }
}

data "external" "secrets" {
  program = ["jq", "-r", ".[]", "${path.module}/secrets.json"]
  depends_on = [null_resource.secrets_list]
}

data "aws_secretsmanager_secret_version" "example" {
  for_each = toset(data.external.secrets.result)
  secret_id = each.key
}

output "secrets_values" {
  value = { for secret in data.aws_secretsmanager_secret_version.example : secret.secret_id => secret.secret_string }
}
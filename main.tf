// For resources that needs to be globally unique at cloud provider:
resource "random_uuid" "backend" {
}

// Current user:
data "aws_caller_identity" "backend" {}

locals {
  namespace = "tf-backend-${random_uuid.backend.result}"
  // replace variable because variables cannot use datasources in Terraform
  user_arns = length(var.user_arns) > 0 ? var.user_arns : [data.aws_caller_identity.backend.arn]
}



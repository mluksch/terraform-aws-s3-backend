// For resources that needs to be globally unique at cloud provider:
resource "random_uuid" "backend" {
}

// Current user:
data "aws_caller_identity" "backend" {}

locals {
  namespace = "${var.namespace}-${random_uuid.backend.result}"
  // replace variable because variables cannot use datasources in Terraform
  all_user_arns = concat(var.existing_users, [for new_user in aws_iam_user.new_users: new_user.arn], [data.aws_caller_identity.backend.arn])
}



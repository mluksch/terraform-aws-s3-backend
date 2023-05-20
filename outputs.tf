output "backend-namespace" {
  value = local.namespace
}

output "backend-users" {
  value = local.all_user_arns
}

output "backend-s3-config" {
  value = {
    bucket = aws_s3_bucket.backend.id
    region = "eu-central-1"
    encrypt = true
    role_arn = aws_iam_role.backend.arn
    dynamodb_table = aws_dynamodb_table.backend.id
  }
}
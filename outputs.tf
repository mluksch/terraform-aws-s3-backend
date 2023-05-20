output "backend-namespace" {
  value = local.namespace
}

output "backend-users" {
  value = local.all_user_arns
}

output "backend-role" {
  value = aws_iam_role.backend.arn
}

output "backend-s3" {
  value = aws_s3_bucket.backend.arn
}

output "backend-dynamodb" {
  value =  aws_dynamodb_table.backend.arn
}
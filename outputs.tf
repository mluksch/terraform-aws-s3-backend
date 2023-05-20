output "backend-namespace" {
  value = local.namespace
}

output "backend-users" {
  value = local.all_user_arns
}

output "backend-role" {
  value = aws_iam_role.backend.arn
}

output "backend-s3-bucket-id" {
  value = aws_s3_bucket.backend.id
}

output "backend-dynamodb-table-id" {
  value =  aws_dynamodb_table.backend.id
}
output "namespace" {
  value = local.namespace
}

output "user_arns" {
  value = local.all_user_arns
}

output "role" {
  value = aws_iam_role.backend.arn
}
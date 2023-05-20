// Create new_users
resource "aws_iam_user" "new_users" {
  for_each = toset(var.new_users)
  name = each.key
  tags = {
    namespace = local.namespace
  }
}

// Create Access Keys for new_users
resource "aws_iam_access_key" "new_users" {
  for_each = aws_iam_user.new_users
  user = each.value.name
}

// Save Access Keys to files
resource "local_file" "new_users" {
  for_each = aws_iam_access_key.new_users
  filename = "${each.value.user}.key"
  content = jsonencode({
    access_key: each.value.id,
    secret_key: each.value.secret,
  })
}

// Rollen entkoppeln die Principals von Policies
// z.b. S3-Zugriff + Dynamodb-Zugriff
// D.h. das "Was" (Policy) wird vom Wer (Rolle) entkoppelt
// Sind also hauptsächlich dazu da, zu definieren, wer diese Rolle annehmen darf
// Vorteil: Eine Rolle kann für mehrere Policies wiederverwendet werden.
resource "aws_iam_role" "backend" {
  name = local.namespace
  // Wer darf diese Rolle annehmen?
  assume_role_policy = data.aws_iam_policy_document.backend.json
  tags = {
    namespace = local.namespace
  }
}

// Die Assume-Role-Policy der Rolle definieren:
// Wer darf diese Rolle annehmen?
data "aws_iam_policy_document" "backend" {
  statement {
    actions = ["sts:AssumeRole"]
    // Wer oder was darf diese Rolle annehmen?
    principals {
      identifiers = local.all_user_arns
      // type        = "Service" für einen AWS-Service
      type = "AWS" // AWS-type, wenn man ARNs benutzen will als identifiers
    }
  }
}

// Die Policy definieren, worauf diese Rolle Zugriff hat:
data "aws_iam_policy_document" "backend-role" {
  statement {
    actions = ["s3:*"]
    effect = "Allow"
    // Need to add 2 resources for a S3-Bucket
    // "<s3_bucket>" & "<s3_bucket>/*"
    resources = [aws_s3_bucket.backend.arn, "${aws_s3_bucket.backend.arn}/*"]
  }
  statement {
    actions = ["dynamodb:*"]
    effect = "Allow"
    resources = [aws_dynamodb_table.backend.arn]
  }
  // Optional: Just for NoSql-Workbench but not required for the s3-backend
  statement {
    actions = ["dynamodb:ListTables"]
    effect = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "backend" {
  name = local.namespace
  policy = data.aws_iam_policy_document.backend-role.json
  role   = aws_iam_role.backend.id
}

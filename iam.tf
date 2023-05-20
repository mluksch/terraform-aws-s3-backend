// Rollen entkoppeln die Principals von Policies
// z.b. S3-Zugriff + Dynamodb-Zugriff
// D.h. das "Was" (Policy) wird vom Wer (Rolle) entkoppelt
// Sind also hauptsächlich dazu da, zu definieren, wer diese Rolle annehmen darf
// Vorteil: Eine Rolle kann für mehrere Policies wiederverwendet werden.
resource "aws_iam_role" "backend" {
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
      identifiers = local.user_arns
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
    resources = [aws_s3_bucket.backend.arn]
  }
  statement {
    actions = ["dynamodb:*"]
    effect = "Allow"
    resources = [aws_dynamodb_table.backend.arn]
  }
}

resource "aws_iam_role_policy" "backend" {
  policy = data.aws_iam_policy_document.backend-role.json
  role   = aws_iam_role.backend.id
}

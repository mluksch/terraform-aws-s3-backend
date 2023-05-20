resource "aws_dynamodb_table" "backend" {
  name = local.namespace
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  // default ist hier (d.h. wenn man nix angibt):
  // billing_mode = "PROVISIONED"
  // mit Pflichtangaben:
  // read_capacity  = 20
  // write_capacity = 20
  billing_mode = "PAY_PER_REQUEST"

  tags = {
    namespace = local.namespace
  }
}
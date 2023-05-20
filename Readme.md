# TF Backend S3-Module

#### Inputs
    - namespace: string
    - existing_users: string[] - ARNs to existing IAM users
    - new_users: string[] - Usernames of new users getting created (access keys will get outputted into *.key-files)

#### Outputs
    - backend-namespace: string
    - backend-users: string[] - ARNs of all users with the role
    - backend-s3-config: config for s3-backend
    
#### How to use
versions.tf:
```terraform
terraform {
  backend "s3" {
    key = "my-cool-project/tf-test-77"
    // TODO copy-paste "backend-s3-config" from the output in here
    // TODO for ex:
    bucket = "example-backend-44d4192f-7cf3-a3e4-7a15-d2db81eade18"
    region = "eu-central-1"
    encrypt = true
    role_arn = "arn:aws:iam::536209942758:role/example-backend-44d4192f-7cf3-a3e4-7a15-d2db81eade18"
    dynamodb_table = "example-backend-44d4192f-7cf3-a3e4-7a15-d2db81eade18"
  }
}
```

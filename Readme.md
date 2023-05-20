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

- Possibility 1:
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

- Possibility 2:
```terraform
// Create a S3-Backend for TF by module invocation
module "s3-backend" {
  // just delete "https://" from the repo-url
  source = "github.com/mluksch/aws-s3-tf-backend.git"
  namespace = "my-cool-project"
}
```
Afterwards you can use the output to hardcode the backend-config like in "Possibilty1".
Unfortunately using Variables out Outputs is not allowed in the backend-config

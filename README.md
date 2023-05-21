# TF Backend S3-Module

#### Inputs
    - namespace: string
    - existing_users: string[] - ARNs to existing IAM users
    - new_users: string[] - Usernames of new users getting created (access keys will get outputted into *.key-files)

#### Outputs
    - backend-namespace: string
    - backend-users: string[] - ARNs of all users with the role
    - backend-s3-config: config for s3-backend
    
#### How to use for me
versions.tf:

Put this into your S3-Backend-Config:
```terraform
terraform {
  backend "s3" {
    key = "<some customizable project-specific Key>"
    bucket = "mluk-backend-1c9e27d2-8f8f-6ba6-feea-650dba519d69"
    dynamodb_table = "mluk-backend-1c9e27d2-8f8f-6ba6-feea-650dba519d69"
    encrypt = true
    region = "eu-central-1"
    role_arn = "arn:aws:iam::536209942758:role/mluk-backend-1c9e27d2-8f8f-6ba6-feea-650dba519d69"
  }
}
```

#### How to use for others
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
Unfortunately using Variables or Module-Outputs or any other TF-Element is not allowed in the backend-config.
So you need to hardcode the backend-config!


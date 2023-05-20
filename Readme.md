# TF Backend S3-Module

#### Inputs
    - namespace: string
    - existing_users: string[] - ARNs to existing IAM users
    - new_users: string[] - Usernames of new users getting created (access keys will get outputted into *.key-files)

#### Outputs
    - backend-namespace: string
    - backend-users: string[] - ARNs of all users with the role
    - backend-role: string - Role to assume with access to S3 & Dynamodb
    - backend-s3: string - ARN of created role with access of S3-Bucket
    - backend-dynamodb: string - ARN of Dynamodb-Table

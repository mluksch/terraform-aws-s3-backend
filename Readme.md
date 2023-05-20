# TF Backend S3-Module

#### Inputs
    - namespace: string
    - existing_users: string[] - ARNs to existing IAM users
    - new_users: string[] - Usernames of new users getting created (access keys will get outputted into *.key-files)

#### Outputs
    - backend-namespace: string
    - backend-users: string[] - ARNs of all users with the role
    - backend-role: string - Role-ARN for assuming in order to obtain S3-Access & Dynamodb-Access
    - backend-s3-bucket-id: string - S3-Bucket-ID
    - backend-dynamodb-table-id: string - Dynamodb-Table-ID

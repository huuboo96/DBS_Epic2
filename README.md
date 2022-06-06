# DBS_Epic2

#  AWS Cloud Formation Template: Resources - AWS EC2 Instance with Amazon Linux AMI, AWS Security Group, Amazon S3 Bucket

This [template](main_cloudformation.json) creates a CloudFormation stack :

   * AWS EC2 Instance
   * AWS Security Group
   * AWS S3 Bucket
   * Simple Python Lambda function 
   * IAM Roles and Policies

## How to run?

Prerequisite : [AWS account](https://aws.amazon.com/) and [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/installing.html)
   
Create a package by running following AWS CLI command

```
aws cloudformation package --template-file main_cloudformation.json --s3-bucket <your-bucket-name> 
    --output-template-file main_cloudformation_output.json
```

Create Stack using following command

```
aws cloudformation deploy --template-file main_cloudformation.json --stack-name <your-stack-name> --capabilities CAPABILITY_IAM
```
## Test

List stack resources using following command 

```
aws cloudformation list-stack-resources --stack-name <your-stack-name>
```

#!/usr/bin/env bash
aws cloudformation package --template-file main_cloudformation.json --s3-bucket s3bucket --output-template-file main_cloudformation_output.json
aws cloudformation deploy --template-file main_cloudformation_output.json --stack-name ec2-lambda-stack-hk --capabilities CAPABILITY_IAM
#!/usr/bin/env bash
aws cloudformation package --template-file cloudformation_template.yaml --s3-bucket s3bucket --output-template-file cloudformation_template_output.yaml
aws cloudformation deploy --template-file cloudformation_template_output.yaml --stack-name hkozu-ec2-stack-full --capabilities CAPABILITY_NAMED_IAM
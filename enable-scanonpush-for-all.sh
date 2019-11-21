#!/bin/bash
printf "Enabling scan-on-push for all repositories...\n"
aws ecr describe-repositories --query 'repositories[*].[repositoryName,imageScanningConfiguration.scanOnPush]' --output text | grep False | awk '{print $1}' | while read line; do aws ecr put-image-scanning-configuration --repository-name $line --image-scanning-configuration scanOnPush=true --region eu-west-1; sleep 1; done

#!/bin/bash
#Config
REGION="eu-west-1"

printf "Enabling scan-on-push for all repositories...\n"
aws ecr describe-repositories \
--query 'repositories[*].[repositoryName,imageScanningConfiguration.scanOnPush]' \
--output text | grep False | awk '{print $1}' | \
while read line; do aws ecr put-image-scanning-configuration --repository-name $line \
--image-scanning-configuration scanOnPush=true --region $REGION; sleep 1; done

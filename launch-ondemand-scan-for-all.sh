#!/bin/bash
#Config
REGION="eu-west-1"

printf "Starting scan for last images...\n"
aws ecr describe-repositories --query 'repositories[*].[repositoryName,imageScanningConfiguration.scanOnPush]' --output text \
| awk '{print $1}' | while read repo; \
do aws ecr describe-images --repository-name $repo  --query 'imageDetails[*].[imageDigest,imagePushedAt] \
| reverse(sort_by(@, &[1])) | [0][0]' \
| while read digest; do aws ecr start-image-scan --repository-name $repo --image-id imageDigest=$digest \
--region $REGION; sleep 1; done; sleep 1; done

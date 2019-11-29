#!/bin/bash
#Config
REGION="eu-west-1"

printf "Getting latest results into results.json file...\n"
aws ecr describe-repositories --query 'repositories[*].[repositoryName,imageScanningConfiguration.scanOnPush]' --output text \
| awk '{print $1}' | while read repo; \
do aws ecr describe-images --repository-name $repo  --query 'imageDetails[*].[imageDigest,imagePushedAt] | reverse(sort_by(@, &[1])) | [0][0]' \
| while read digest; do aws ecr describe-image-scan-findings \
--repository-name $repo --image-id imageDigest=$digest --region $REGION \
| jq -c '{CVE: .imageScanFindings.findings[], repositoryName: .repositoryName, 
imageScanStatus: .imageScanStatus.status, scanCompletedAt: .imageScanFindings.imageScanCompletedAt, 
vulnDBUpdatedAt: .imageScanFindings.vulnerabilitySourceUpdatedAt}'; sleep 1; done; sleep 1; done > result.json

# aws-ecr-scans-automation

AWS recently launched vulnerability scans which is a great addition but totally lacks any GUI to review results.

The goal of this repository is to provide an automation for:

  1) Enabling scan-on-push feature for all repositories in your ECR
  2) Launching on demand scans for latest uploaded images on all repositories
  3) Retrieving results and sending them via filebeat to ElasticSearch cluster for review
  
  
# Requirements
- jq
- elasticsearch
- filebeat
- aws console
- aws creds set in ~/.aws/credentials file


#Usage
1. Change REGION variable according to your AWS region
2. Run scripts:
	- 2.1) enable-scanonpush-for-all.sh - to enable ScanOnPush setting for all ECR repositories in a respective region
	- 2.2) launch-ondemand-scan-for-all.sh - to run scan on demand for latest uploaded images in all ECR repositories
	- 2.3) retrieve-results.sh - to retrieve image scan results for latest uploaded images in all ECR repositories and put then in result.json file
  
  

You can schedule all three scripts to run on a regular basis via crontab to always get the latest vulnerability state. 
Please do keep in mind that AWS puts limitations (currently one on demand scan per image per 24h).

# aws-ecr-scans-automation
Automating ECR scans and results retrieval + integration with ElasticSearch

AWS recently launched vulnerability scans which is a great addition but totally lacks any GUI to see results.
The goal of this repository is to provide an automation for:

  1) Enabling scan-on-push feature for all repositories in your ECR
  2) Launching on demand scan for latest uploaded images on all repositories
  3) Retrieving results and sending them via filebeat to ElasticSearch cluster for review
  
  
Requirements:
- jq
- elasticsearch
- filebeat
- aws creds set in ~/.aws/credentials file

# AWS Serverless Infrastructure


### Description
This repository contains the Terraform configuration for deploying a serverless infrastructure on AWS. The infrastructure utilizes AWS Lambda for computing, Amazon S3 for storage, AWS KMS for encryption, and API Gateway for routing requests. EventBridge is used for scheduling tasks and triggering Lambda functions.

### Architecture Diagram

Below is the architecture diagram representing the serverless setup:

![Ar](https://github.com/HashTekSolutions/s3-lambda-api/assets/113921841/f2efefb6-48ca-4275-96a6-c14b8a4694aa)

## Folder Structure

```
terraform-project/
│
├── modules/          # Reusable Terraform modules.
│   ├── kms/          # KMS key configurations.
│   ├── s3/           # S3 bucket setups.
│   ├── lambda/       # Lambda function definitions.
│   ├── iam/          # IAM role and policy specifications.
│   └── api_gateway/  # API Gateway resources.
│
└── env/     # Environment-specific configs.
    ├── dev/  
         ├── main.tf           # Main Terraform configuration.
         ├── variables.tf      # Variable definitions.
         ├── outputs.tf        # Output values.
         ├── providers.tf        # Development environment.
    
```

## Deployment Instructions and Dependencies

### Prerequisites:
AWS CLI with appropriate access rights.
Terraform installed on your local machine.

### Deployment Steps:
##### Initialization:
Navigate to the environment directory (`env/dev`) and run `terraform init` to initialize Terraform.
##### Plan:
Execute `terraform plan` to review the changes to be applied.
##### Apply:
Use `terraform` apply to provision the resources on AWS.
##### Endpoint URL
Lambda API Endpoint: "https://mmt73opuqa.execute-api.eu-north-1.amazonaws.com/dev/retrieve_most_recent_object_dev"
This endpoint allows fetching the latest S3 object as per the serverless setup.

##### Important Note:
The provided endpoint URL is specific to the development environment of this project and might not be publicly accessible.

### Tear Down Instructions
##### To tear down the deployed infrastructure:

Navigate to the environment directory (`env/dev`).
Run `terraform destroy`
Confirm the destruction of resources by entering `yes` when prompted.

Ensure careful consideration before executing the tear down command as it will remove all provisioned resources.


# Brief Summary of the Implemented Solution:

### 1. why the Services/Components were chosen Alternatives?

##### Serverless Architecture (AWS Lambda): 
Chosen for scalability, cost-efficiency, and faster development compared to self-managed servers or containerized applications.
Storage (Amazon S3): Ideal for storing large, unstructured data objects at scale and with high durability, compared to relational databases or file systems.

##### Encryption (AWS KMS):
Provides centralized key management, simplifies rotation and access control, and integrates seamlessly with S3 for encryption, compared to client-side encryption or custom solutions.

##### API Gateway:
Easy-to-use managed service for creating and managing APIs with built-in security features, compared to custom API servers using frameworks.

##### EventBridge (Triggering Lambda Function 1):
Potentially chosen for its flexibility in event routing and centralized management compared to CloudWatch Events or cron jobs (on some platforms).

### 2.How the cost of the implementation scales as traffic increases?

##### Pay-per-use model: 
You are charged for Lambda executions, S3 storage used, KMS requests, and API Gateway requests.
##### Automatic scaling: 
Lambda scales functions automatically based on traffic, minimizing costs during low-traffic periods.
##### S3 storage costs:
Pay for the amount of data stored and retrieved. Optimize by using appropriate storage class based on access frequency.
##### API Gateway throttling:
Set limits to prevent excessive costs during unexpected traffic spikes.


### 3.How to monitor the implementation for availability and performance?

##### CloudWatch:
Monitor Lambda function execution times, errors, and invocations.
##### S3 object lifecycle management:
Track object versions and deletions.
##### CloudWatch metrics for API Gateway: 
Monitor API latency, throttling events, and request/response codes.
##### Alerts:
Configure CloudWatch alerts to notify you of potential issues.

### 4.How to recover from a regional disaster and impact to end users?

##### S3 replication:
Configure S3 replication to a different region for disaster recovery.
##### Lambda versioning:
Maintain previous function versions for rollback in case of issues with new deployments.
##### EventBridge rule retries: 
Configure retries for EventBridge rules to handle temporary disruptions.
##### End-user impact:
During a regional disaster, API calls might experience latency or errors until failover to the secondary region occurs.


### 5. How the implementation complies with best practices (AWS Well Architected Framework or Google Cloud Architecture Framework)?

##### Scalability:
The serverless architecture scales automatically to handle traffic spikes. (AWS Well-Architected Framework - Performance Efficiency)
##### Cost-efficiency:
Pay-per-use model ensures you only pay for resources you utilize. (AWS Well-Architected Framework - Cost Optimization)
##### Security:
Encrypted data at rest in S3 and KMS for key management. (Both AWS and Google Cloud promote security as a core principle)
##### Fault Tolerance:
S3 replication and potential Lambda versioning offer some level of fault tolerance. (Both frameworks emphasize resilience)


## In Conclusion

The architecture leverages serverless compute with AWS Lambda, secure object storage with Amazon S3, centralized key management with AWS KMS, and an API Gateway for user requests. EventBridge adds an optional layer of scheduling capabilities.
This included Terraform configuration facilitates deployment across environments, while the clear folder structure promotes maintainability and reusability. The detailed deployment instructions guide users through the setup process, and the tear down instructions ensure a controlled removal of resources.


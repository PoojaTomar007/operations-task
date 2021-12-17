# Xeneta Operations Task
  
The task is two-fold:
* A practical case of developing a deployable development environment based on a simple application.
* A theoretical case describing and evolving a data ingestion pipeline.
Some general points:
## Practical case: Deployable development environment
### Pre-requisites
* Below are the pre-requisites
  - Use Ubuntu 18 and install git and terraform on it
### How to use?
* Run below commands:
  - git clone https://github.com/PoojaTomar007/operations-task.git
  - ssh-keygen (press enter and leave everything as default)
  - cd operations-task/terraform
  - terraform init
  - terraform apply
### Testing
* ssh on newly created VM and run below command to get the data from api service and postgres database
  - curl "http://127.0.0.1:3000/rates?date_from=2021-01-01&date_to=2021-01-31&orig_code=CNGGZ&dest_code=EETLL"

* NOTE: 
    - you can use the ssh key you have created to ssh newly created instance.
    - In terraform output you can find the public ip of the instance.
    - Example: ssh -i path-to-ssh-key poojatomar0292@public-ip

## Case: Data ingestion pipeline
### Architecture (Initial)
<img width="1208" alt="Screenshot 2021-12-17 at 12 45 38 PM" src="https://user-images.githubusercontent.com/90127609/146504862-9b682c2e-3e00-4f05-a3b4-fbb10735733f.png">
Data can come from customer side or from any endpoints, I assume it is coming from on-premises. Data Sync Agent can be used to transfer the data over TLS TO AWS data sync service and then data can be copied to AWS S3 bucket. AWS S3 bucket can be a trigger point and some services of AWS can be used to transform and load the data like AWS Lambda or Glue can be used to transform the data and AWS Batch, Data pipeline and Glue can be used to load the data. There are two micro services one is gunicorn and PostgreSQL database. We can run the application and database into AWS EKS or ECS. Or we can run application into AWS EKS or ECS and postgres database into AWS RDS.

### Architecture (Final)
<img width="1241" alt="Screenshot 2021-12-17 at 1 13 11 PM" src="https://user-images.githubusercontent.com/90127609/146508162-b9ab0db3-adbb-4a9d-8487-71471aff4f24.png">
To transfer the data I have used AWS DataSync. It is a secure, online service that automates and accelerates moving data between on premises and AWS storage services. DataSync can copy data between Network File System (NFS) shares, Server Message Block (SMB) shares, Hadoop Distributed File Systems (HDFS), self-managed object storage, AWS Snowcone, Amazon Simple Storage Service (Amazon S3) buckets, Amazon Elastic File System (Amazon EFS) file systems, and Amazon FSx for Windows File Server file systems.

For ETL operations I have used AWS Glue. It can run your ETL jobs as new data arrives. You can use an AWS Lambda function to trigger your ETL jobs to run as soon as new data becomes available in Amazon S3. You can also register this new dataset in the AWS Glue Data Catalog as part of your ETL jobs. Using Cloudwatch we can monitor each ETL job and Lambda function executions.

### Aditional Questions and Answers
Question 1- The batch updates have started to become very large, but the requirements for their processing time are strict.
Answer: In many cases, batch processing can have tight timelines and require significant resources, especially if the batch processing job is processing big data. When timelines are strict and data is large we need to take care of few things like:
 - latency in data collection: For that we can use direct connect and aws data sync service so that we can collect data with low latency
 - Highly available services: We have used AWS native services those SLA is maitained by AWS and we can rely on the providors high availablity solutions.
 - Data Transform and load in regular fashion: We have used services like Batch, Glue, Lambda, Data Pipelines to transform and load the data.

Question 2- Code updates need to be pushed out frequently. This needs to be done without the risk of stopping a data update already being processed, nor a data response being lost.
Answer: We can use CI/CD pipelines to update the code with zero downtime. We can use blue/green deployments to push the changes with zero downtime.

Question 3- For development and staging purposes, you need to start up a number of scaled-down versions of the system.
Answer: Ya we can use scaled-down versions of the system in development and staging environments. We dont require the realtime data to test in development environment. We can segregate the data sources in S3 bucket for lower environments.

### Addressing below scenarios
- Which parts of the system are the bottlenecks or problems that might make it incompatible with the new requirements?
   - Answer: Data collection can be the bottleneck and we need to remove the latency so that we can collect the data at high speed by using direct connect.


- How would you restructure and scale the system to address those?
   - Answer: By using AWS Managed services we can leave the admin overheads to Amazon itself and if we need to scale any services on kubernetes level or vm level we need to scale it through concepts like auto-scaling in vm and replica sets in kubernetes. We can also leverage Kubernetes Cluster Autoscaler that will automatically adjusts the number of nodes in your cluster when pods fail or are rescheduled onto other nodes.

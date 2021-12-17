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
  - cd operations-task/terraform
  - terraform init
  - terraform apply
### Testing
* ssh on newly created VM and run below command to get the data from api service and postgres database
  - curl "http://127.0.0.1:3000/rates?date_from=2021-01-01&date_to=2021-01-31&orig_code=CNGGZ&dest_code=EETLL"

## Case: Data ingestion pipeline
### Architecture (Initial)
<img width="1208" alt="Screenshot 2021-12-17 at 12 45 38 PM" src="https://user-images.githubusercontent.com/90127609/146504862-9b682c2e-3e00-4f05-a3b4-fbb10735733f.png">
Data can come from customer side or from any endpoints, I assume it is coming from on-premises. Data Sync Agent can be used to transfer the data over TLS TO AWS data sync service and then data can be copied to AWS S3 bucket. AWS S3 bucket can be a trigger point and some services of AWS can be used to transform and load the data like AWS Lambda or Glue can be used to transform the data and AWS Batch, Data pipeline and Glue can be used to load the data. There are two micro services one is gunicorn and PostgreSQL database. We can run the application and database into AWS EKS or ECS. Or we can run application into AWS EKS or ECS and postgres database into AWS RDS.

### Architecture (Final)
<img width="1241" alt="Screenshot 2021-12-17 at 1 13 11 PM" src="https://user-images.githubusercontent.com/90127609/146508162-b9ab0db3-adbb-4a9d-8487-71471aff4f24.png">

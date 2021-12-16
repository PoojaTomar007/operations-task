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

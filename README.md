# AWS job queing scripts

## System requirements for the deployment host.

* os: Linux/OSX

* terraform >= `0.11.7`

* docker: latest stable version

* awscli https://aws.amazon.com/cli/

* jq https://stedolan.github.io/jq/

## Quick start. 

1. configure the stack parameters in `terraform/terraform.tfvars` file

2. raise the required AWS infrastructure: `terraform/README.md`

3. send a test messages to the queue: `worker/send_message.py`


When creating an EC2 instance, the `terraform/files/insecure_key` key is used, so you can use it to connect to the EC2 instance.

```
ssh -i terraform/files/insecure_key ec2-user@<ec2_public_ip>
```

# Terraform Templates

Here are the Terraform templates for creating AWS Resources

## Pre-requisites

1. Install [Terraform](https://terraform.io/). This code requires to use a Terraform version `0.11.7` or later.

2. Set up [AWS credentials](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html).

    * Edit ~/.aws/credentials

    * export AWS_PROFILE=MyAwsProfile

### Initialize remote backend

```
terraform init
```

### Terraform Plan

```
terraform plan
```

### Terraform Apply
Please make sure to review the terraform plan before apply.

```
terraform apply
```

### Terrafrom Destroy
```
terrafrom destroy
```


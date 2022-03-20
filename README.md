# nextCloud project
This repository contain source code of nextCloud project which is a part of a software defined system course offered by department of computer engineering, Chulalongkorn University (2020).

## Task
deploy a personal cloud storage software called NextCloud on Amazon web services using an infrastructure-as-code software called Terraform.
[read more](https://github.com/nasri-repositories/nextcloud-aws-terraform/blob/main/assets/Assignment.pdf)

## Architecture
![alt text](https://github.com/nasri-repositories/nextcloud-aws-terraform/blob/main/assets/architecture.png?raw=true)

## How to use

First, you must set the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables.
To set these variables on Linux, macOS, or Unix, use :

```bash
export AWS_ACCESS_KEY_ID=your_access_key_id
export AWS_SECRET_ACCESS_KEY=your_secret_access_key
```

To set these variables on Windows, use :

```bash
set AWS_ACCESS_KEY_ID=your_access_key_id
set AWS_SECRET_ACCESS_KEY=your_secret_access_key
```

After that, you can start terraform by running this following command.

```bash
terraform init
terraform plan
terraform apply
```

## Demo video
https://www.youtube.com/watch?v=Er6ndzvhjpc

## Requirements

- [Terraform](https://www.terraform.io/)
- [Ansible](https://www.ansible.com/)

## Prerequisites

This solution assumes that you have an AWS account setup on the executing machine that has rights to create and delete AWS resources named 'default'.

An example file named `terraform.auto.tfvars.example` contains all variables used for the infrastructure, adjust to your own needs.

## Use

This repository allows the user to spin up infrastructure in order to host a private instance of Mumble server. The infrastructure created is free tier eligible.

Navigate to the `terraform/` directory and use the following commands:

```bash
terraform init
terraform apply

# type in 'yes' when prompted
```

The script generates an inventory file in the `ansible/` directory that should be used in the next step.

Navigate to the `ansible/` directory and use the following command:

```bash
ansible-playbook -i inventory.yaml playbook.yaml
```

At the end of execution the command will give you an IP address that can be entered in the Mumble client for use.

When done, you can delete the infrastructure by simply destroying resources via terraform. Navigate to the `terraform/` directory and use the following commands:

```bash
terraform init
terraform destroy

# type in 'yes' when prompted
```

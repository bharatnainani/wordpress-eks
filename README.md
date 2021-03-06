# eks-terraform-code


This terraform automation code run wordpress site using helm



To run this terraform script, execute the below commands:

### Initialization


```bash
terraform init 
```

### Plan

To generate a terraform execution plan, execute the below command

```bash
terraform plan
```

### Apply

To apply the changes required to reach the desired state of the configuration,
execute the below command

```bash
terraform apply
```

## Requirements

| Name      | Version   |
|-----------|-----------|
| Terraform | >=0.12.23 |

## Terraform Providers Used

| Provider Name | Version |
|---------------|---------|
| aws           | 2.0     |

| Provider Name | Version |
|---------------|---------|
| helm          | 1.0    |

## Inputs

| Name                   | Description                                | Type   | Default Value  |
|------------------------|--------------------------------------------|--------|----------------|
| region                 | Name of the AWS region to deploy application | string |                |
| subnet_ids                | list of subnet ids                      | list |        |
| k8s_cluster_name           | Name of the Cluste                  | string |                |
|   efs_id                           |  AWS efs id                             | string          |               |
| security_group | aws SG | list | |

## Outputs

| Name                              | Description                                    |
|-----------------------------------|------------------------------------------------|
| cluster_endpoint  | Endpoint of EKS cluster  |
|  config_map_aws_auth           |  A kubernetes configuration to authenticate to this EKS cluster                     |
| kubectl_config        |  kubectl config as generated by the module |                    |

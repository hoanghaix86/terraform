# Provision DNS Server

## Pre

```sh
export TF_VAR_proxmox_api_url="http://192.168.100.10:8006/api2/json"
export TF_VAR_proxmox_api_token_id='root@pam!terraform'
export TF_VAR_proxmox_api_token_secrect="63be671d-d150-4254-89ad-7dd4bfd2094b"
```

## Run

```sh
terraform init

terraform plan

terraform destroy

terraform refresh
```
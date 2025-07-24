# Update DNS Record

## Pre

```sh
export DNS_UPDATE_KEYALGORITHM=hmac-sha256
export DNS_UPDATE_KEYNAME=tsig-key.
export DNS_UPDATE_KEYSECRET=GK3CEKSn6XCjUwOXS5DBoLg9pjlARinXCUYaQw50gGg=
export DNS_UPDATE_SERVER=192.168.100.2
export DNS_UPDATE_PORT=53
```

## Run

```sh
terraform init

terraform plan

terraform destroy
```
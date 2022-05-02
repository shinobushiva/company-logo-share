# 環境の構築

- feature (dev)
- dev (dev)
- stg (staging)
- prd (production)

## Network

VPC = 10.0.0.0/16

### feature

EC2(1) app1 = 10.0.51.0/24
EC2(2) app2 = 10.0.52.0/24
RDB(1) db1 = 10.0.53.0/24
RDB(2) db2 = 10.0.54.0/24

### dev

EC2(1) app1 = 10.0.1.0/24
EC2(2) app2 = 10.0.2.0/24
RDB(1) db1 = 10.0.3.0/24
RDB(2) db2 = 10.0.4.0/24

Elasticache(1) = 10.0.77.0/24
Elasticache(2) = 10.0.78.0/24

### staging

EC2(1) app1 = 10.0.11.0/24
EC2(2) app2 = 10.0.12.0/24
RDB(1) db1 = 10.0.13.0/24
RDB(2) db2 = 10.0.14.0/24

### production

EC2(1) app1 = 10.0.21.0/24
EC2(2) app2 = 10.0.22.0/24
RDB(1) db1 = 10.0.33.0/24
RDB(2) db2 = 10.0.44.0/24
Elasticache(1) = 10.0.88.0/24
Elasticache(2) = 10.0.89.0/24

## OPS 環境のInstall

terraformのインストール

```
brew install terraform
```

s3の(sitateru-terraform) へのアクセス権

```
export TF_VAR_access_key=xxxxx
export TF_VAR_secret_key=xxxxx
```

## terraform の使い方

```
terraform plan
terraform apply
```
↑
初回は次のフォルダをカレントにしてinitを実行しておく(stages/dev or staging or producion)
```
terraform init
```

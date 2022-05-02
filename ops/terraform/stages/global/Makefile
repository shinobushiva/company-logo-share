remote-config:
	terraform remote config \
		-backend=s3 \
		-backend-config="bucket=sitateru-terraform" \
		-backend-config="key=scs-v2-api/global/terraform.tfstate" \
		-backend-config="region=ap-northeast-1"
	terraform remote pull

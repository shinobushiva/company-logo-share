# Memo

npm install -g npm
npm i -g @nestjs/cli
 yarn
nest new company-logo-share
cd company-logo-share
yarn add aws-lambda aws-serverless-express express
yarn add -D @types/aws-serverless-express serverless-layers

yarn add -D serverless-offline

<!-- yarn bulid & serverless offline -->
yarn build & yarn sls:offline

serverless deploy --aws-profile izumiken

yarn add @nestjs/graphql @nestjs/apollo graphql apollo-server-express
yarn add graphql-tools
yarn add class-validator class-transformer

nest g resource users
  graphql(code first)

yarn add @nestjs/typeorm typeorm mysql2 reflect-metadata

yarn add -D typeorm-extension

yarn db:create
yarn db:drop

npx ts-node ./node_modules/.bin/typeorm migration:generate src/database/migrations/create-user -d src/config/ormdatasource
npx ts-node ./node_modules/.bin/typeorm migration:run -d src/config/ormdatasource
npx ts-node ./node_modules/.bin/typeorm migration:revert -d src/config/ormdatasource

yarn add -D purdy await-outside

### readings
- https://zenn.dev/naonao70/articles/a91d8835f1832b
- https://zenn.dev/msksgm/articles/20211107-typeorm-ormconfig
- https://qiita.com/potato4d/items/64a1f518abdfe281ce01
- https://zenn.dev/hakushun/articles/7daac74ae9af25
- https://zenn.dev/azukiazusa/articles/e84be9735d357e
- https://www.kindacode.com/snippet/using-enum-type-in-typeorm/
- https://www.wakuwakubank.com/posts/729-typeorm-migration/

## terraform

brew install tfenv
tfenv --version
tfenv list-remote
tfenv install 1.1.9
tfenv use 1.1.9

terraform init

terraform plan --var-file=variables.tf

### readings
https://dev.classmethod.jp/articles/beginner-terraform-install-mac/

## serverless deploy with docker

docker-compose run --rm serverless sh

echo $(aws ecr get-login-password) | docker login --password-stdin --username AWS 535395497623.dkr.ecr.ap-northeast-1.amazonaws.com

### readings
https://zenn.dev/qazx7412/articles/fddbdd5bd6379e4587a3
https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/images-test.html


### ローカルで docker で lambdaを動かす
yarn build
docker build -t company-logo-share_serverless .
docker run --rm --name=company-logo-share_serverless -p 8080:8080 company-logo-share_serverless:latest
docker run -it --entrypoint sh --rm --name=company-logo-share_serverless -p 8080:8080 company-logo-share_serverless:latest
> /lambda-entrypoint.sh handler.hello

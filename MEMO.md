# Memo

npm install -g npm
npm i -g @nestjs/cli
 yarn
nest new company-logo-share
cd company-logo-share
yarn add aws-lambda aws-serverless-express express
yarn add -D @types/aws-serverless-express serverless-layers

serverless plugin install -n serverless-offline

yarn bulid
serverless offline

serverless deploy --aws-profile izumiken

## readings

https://zenn.dev/naonao70/articles/a91d8835f1832b
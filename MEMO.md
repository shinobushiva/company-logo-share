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

yarn add @nestjs/graphql @nestjs/apollo graphql apollo-server-express
yarn add graphql-tools
yarn add class-validator class-transformer

nest g resource users
  graphql(code first)

npm install -g typeorm
yarn add @nestjs/typeorm typeorm mysql2 reflect-metadata

yarn add -D typeorm-extension

yarn db:create
yarn db:drop

npx ts-node ./node_modules/.bin/typeorm migration:generate src/database/migrations/create-user -d src/config/ormdatasource
npx ts-node ./node_modules/.bin/typeorm migration:run -d src/config/ormdatasource
npx ts-node ./node_modules/.bin/typeorm migration:revert -d src/config/ormdatasource

yarn add -D purdy await-outside
## readings
- https://zenn.dev/naonao70/articles/a91d8835f1832b
- https://zenn.dev/msksgm/articles/20211107-typeorm-ormconfig
- https://qiita.com/potato4d/items/64a1f518abdfe281ce01
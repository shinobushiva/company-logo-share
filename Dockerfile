FROM public.ecr.aws/lambda/nodejs:14

RUN npm install -g yarn
RUN npm install -g serverless

COPY package.json yarn.lock ./
COPY dist ./
# build用なのでdevDepsも必要
RUN yarn install --silent --no-progress --frozen-lockfile

# WORKDIR /var/task/
# CMD [ "src/handler.handler" ]
CMD [ "src/handler.hello" ]

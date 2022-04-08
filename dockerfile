# Base
FROM node:16-alpine as base
WORKDIR /app

COPY package.json .
COPY yarn.lock .
COPY .yarnrc.yml .

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN yarn install --use-yarnrc .yarnrc.yml

COPY . .

ENTRYPOINT ["/entrypoint.sh"]

# Production Build
FROM base as production

RUN npm run build

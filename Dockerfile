# Base Image from dockerhub node:21.7.1-alpine3.19
FROM node@sha256:dad4152c8e3e4ec412f9f09043ee5ec59d33bb73165fdb682be486d7cabc6065 

RUN mkdir app

WORKDIR /app

COPY . .

RUN npm install

USER node

ENTRYPOINT [ "npm", "start" ]
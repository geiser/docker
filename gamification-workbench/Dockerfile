FROM node:16-alpine AS v0.01

MAINTAINER Geiser Chalco <geiser@alumni.usp.br>

LABEL org.label-schema.license="GPL-3.0" \
      org.label-schema.vcs-url="https://github.com/geiser/gamification-workbench" \
      org.label-schema.vendor="Gamification Workbench" \
      maintainer="Geiser Chalco <geiser@alumni.usp.br>"

WORKDIR /home/node/app

RUN npm install -g increase-memory-limit
RUN increase-memory-limit
RUN npm install -g concurrently
RUN npm install -g react-scripts

COPY package*.json ./
RUN npm install
RUN rm package*.json

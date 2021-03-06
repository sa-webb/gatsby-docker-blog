FROM node:alpine

WORKDIR /app

RUN \
  apk add --no-cache python make g++ && \
  apk add vips-dev fftw-dev --update-cache \
  --repository http://dl-3.alpinelinux.org/alpine/edge/community \
  --repository http://dl-3.alpinelinux.org/alpine/edge/main \
  && rm -fR /var/cache/apk/*

RUN npm install -g gatsby-cli

EXPOSE 8000 

COPY ./package.json .

RUN yarn install && yarn cache clean

COPY . .

CMD ["yarn", "develop", "-H", "0.0.0.0" ]
FROM dockerfile/nodejs
MAINTAINER Joseph McCormick, esmevane@gmail.com
RUN npm install -g grunt-cli
WORKDIR /app
ADD package.json /app/package.json
RUN npm install
ADD . /app
ENV NODE_ENV development
EXPOSE 9001
ENTRYPOINT grunt serve

FROM node:12-slim as builder
LABEL maintainer="Thanh Nguyen<nnthanh101@gmail.com>"

RUN apt-get update && apt-get -y install --no-install-recommends -q nodejs curl unzip bash git apt-utils gnupg2
WORKDIR /webapp
COPY package.json .
RUN yarn install
COPY . .
RUN yarn build


FROM node:12-slim

# Install latest chrome dev package and fonts to support major charsets (Chinese, Japanese, Arabic, Hebrew, Thai and a few others)
# Note: this installs the necessary libs to make the bundled version of Chromium that Puppeteer installs, work.

# RUN apt-get update && apt-get -y install --no-install-recommends -q wget apt-utils gnupg2 && \
# apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
# libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
# libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
# libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
# fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst ttf-freefont \
# ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget && \
# wget https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64.deb && \
# dpkg -i dumb-init_*.deb && rm -f dumb-init_*.deb && \
# apt-get clean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*
RUN  apt-get update && apt-get -y install --no-install-recommends -q wget apt-utils gnupg2 && \
     apt-get -y install xvfb gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 \
     libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 \
     libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
     libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 \
     libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget && \
     rm -rf /var/lib/apt/lists/*

RUN  wget --quiet https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -O /usr/sbin/wait-for-it.sh \
     && chmod +x /usr/sbin/wait-for-it.sh

RUN apt-get update \
    && apt-get install -y python3 python3-pip python3-setuptools groff less \
    && pip3 install --upgrade pip \
    && apt-get clean

RUN pip3 --no-cache-dir install --upgrade awscli

WORKDIR /webapp

##########
## npm run build
##
## nohup node twitter_stream_producer_app.js &
## echo "Service started."
##########
COPY --from=builder /webapp/dist/package.json .
RUN npm install --production

## TODO
# COPY --from=builder /webapp/.env.default .
# COPY --from=builder /webapp/dist/. .
# COPY --from=builder /webapp/src/views/. ./src/views
# COPY --from=builder /webapp/build.properties .

ENV NODE_TLS_REJECT_UNAUTHORIZED 0
ENV DISABLE_MONITOR true
ENV LOG_FILE false
ENV LOGGER_COLORIZE false

EXPOSE 3333

CMD ["npm", "start"]
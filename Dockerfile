FROM node:8.11-alpine

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
    git \
  && pip install virtualenv \
  && rm -rf /var/cache/apk/*

RUN npm install -g @angular/cli

# chrome install
RUN mkdir /noto && apk add --update --no-cache \
        chromium \
        udev \
        ttf-freefont
ADD https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip /noto 

WORKDIR /noto

RUN unzip NotoSansCJKjp-hinted.zip && \
    mkdir -p /usr/share/fonts/noto && \
    cp *.otf /usr/share/fonts/noto && \
    chmod 644 -R /usr/share/fonts/noto/ && \
    fc-cache -fv && rm -rf /noto

ENV CHROME_BIN /usr/bin/chromium-browser

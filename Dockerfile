FROM node:0.10-slim

ENV APP_DIRECTORY /curvytron

WORKDIR ${APP_DIRECTORY}

RUN apt-get update && \
    apt-get install -y \
        git \
        python \
        make \
        g++ && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

RUN git clone https://github.com/Curvytron/curvytron.git .

COPY ./bower.json ${APP_DIRECTORY}

RUN npm install gulp -g && \
    npm install bower -g && \
    npm install && \
    bower install --allow-root \
    gulp

EXPOSE 8080

CMD node bin/curvytron.js

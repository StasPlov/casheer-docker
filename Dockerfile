# base image
FROM wordpress:php8.2-fpm

# Install git and other dependencies
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install git bash curl

# Install nvm env
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION lts/iron

RUN mkdir -p $NVM_DIR
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Add nvm.sh to bash environment so we can use nvm in the next RUN command
SHELL ["/bin/bash", "--login", "-c"]

# Install Node using nvm
RUN . "$NVM_DIR/nvm.sh" && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default

# Add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/versions/node/$(nvm version)/lib/node_modules
ENV PATH $NVM_DIR/versions/node/$(nvm version)/bin:$PATH
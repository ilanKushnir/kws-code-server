# Start from the code-server Debian base image
FROM codercom/code-server:latest
USER coder
# Use bash shell
ENV SHELL=/bin/bash
# Fix permissions for code-server
RUN mkdir -p /home/coder/.local
RUN sudo chown -R coder:coder /home/coder/.local


# Install apt packages:
#######################
RUN sudo apt update && sudo apt upgrade -y
# Install Curl
RUN sudo apt install software-properties-common apt-transport-https curl -y
RUN sudo add-apt-repository ppa:savoury1/curl34 -y
RUN sudo apt install curl -y
# Install Git
RUN sudo apt install git
# Install NVM, Node, NPM
RUN sudo git clone http://github.com/creationix/nvm.git /root/.nvm
RUN sudo chmod -R 777 /root/.nvm/
RUN sudo bash /root/.nvm/install.sh
RUN sudo bash -i -c 'nvm install 14'
RUN sudo bash -i -c 'nvm install 16'
RUN sudo bash -i -c 'nvm use 16'


# Copy files:
#############
# Apply VS Code settings
COPY ./config/settings.json .local/share/code-server/User/settings.json


# Port
ENV PORT=8080

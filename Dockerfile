# Start from the code-server Debian base image
FROM codercom/code-server:latest
USER coder
# Use bash shell
ENV SHELL=/bin/bash
# Fix permissions for code-server
RUN mkdir -p /home/coder/.local
RUN sudo chown -R coder:coder /home/coder/.local


# Install a VS Code extension:
##############################
# Note: code-server use a different marketplace than VS Code. See https://github.com/cdr/code-server/blob/main/docs/FAQ.md#differences-compared-to-vs-code
# HACK: use MS marketplace
ENV EXTENSIONS_GALLERY='{"serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery","cacheUrl": "https://vscode.blob.core.windows.net/gallery/index","itemUrl": "https://marketplace.visualstudio.com/items","controlUrl": "","recommendationsUrl": ""}'
#  - GENERAL -----------------------------------
RUN code-server --install-extension pnp.polacode
RUN code-server --install-extension tomoki1207.pdf
RUN code-server --install-extension dbaeumer.jshint
RUN code-server --install-extension mikestead.dotenv
RUN code-server --install-extension redhat.vscode-yaml
RUN code-server --install-extension yzane.markdown-pdf
RUN code-server --install-extension steoates.autoimport
RUN code-server --install-extension ms-vscode.PowerShell
RUN code-server --install-extension rintoj.json-organizer
RUN code-server --install-extension eg2.vscode-npm-script
RUN code-server --install-extension esbenp.prettier-vscode
RUN code-server --install-extension GraphQL.vscode-graphql
RUN code-server --install-extension dbaeumer.vscode-eslint
RUN code-server --install-extension wayou.vscode-todo-highlight
RUN code-server --install-extension christian-kohler.npm-intellisense
RUN code-server --install-extension christian-kohler.path-intellisense
RUN code-server --install-extension streetsidesoftware.code-spell-checker
RUN code-server --install-extension VisualStudioExptTeam.vscodeintellicode
RUN code-server --install-extension streetsidesoftware.code-spell-checker-hebrew
#  - GIT ---------------------------------------------
RUN code-server --install-extension mhutchie.git-graph
RUN code-server --install-extension GitLab.gitlab-workflow
RUN code-server --install-extension codezombiech.gitignore
RUN code-server --install-extension donjayamanne.githistory
RUN code-server --install-extension GitHub.vscode-pull-request-github
#  - FRONTEND -----------------------------------------------
RUN code-server --install-extension tht13.html-preview-vscode
RUN code-server --install-extension xabikos.JavaScriptSnippets
RUN code-server --install-extension thekalinga.bootstrap4-vscode
RUN code-server --install-extension kamikillerto.vscode-colorize
#  - BACKEND ------------------------------------
RUN code-server --install-extension mtxr.sqltools
RUN code-server --install-extension ms-python.python
RUN code-server --install-extension LawrenceGrant.cql
RUN code-server --install-extension 42Crunch.vscode-openapi
RUN code-server --install-extension cweijan.vscode-redis-client
RUN code-server --install-extension waderyan.nodejs-extension-pack
RUN code-server --install-extension jasonnutter.search-node-modules
RUN code-server --install-extension donjayamanne.python-extension-pack
RUN code-server --install-extension donjayamanne.python-environment-manager
#  - OPS -----------------------------------------
RUN code-server --install-extension redhat.ansible
RUN code-server --install-extension HashiCorp.terraform
RUN code-server --install-extension ms-azuretools.vscode-docker
RUN code-server --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
#  - THEMES -----------------------------------
RUN code-server --install-extension teabyii.ayu
RUN code-server --install-extension miguelsolorio.fluent-icons
RUN code-server --install-extension GitHub.github-vscode-theme
RUN code-server --install-extension zhuangtongfa.Material-theme
RUN code-server --install-extension dracula-theme.theme-dracula
RUN code-server --install-extension monokai.theme-monokai-pro-vscode


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

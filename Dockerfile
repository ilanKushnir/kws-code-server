# Start from the code-server Debian base image
FROM codercom/code-server:latest
USER coder
# Use bash shell
ENV SHELL=/bin/bash
# Fix permissions for code-server
RUN mkdir -p /home/coder/.local
RUN sudo chown -R coder:coder /home/coder/.local


# Copy files:
#############
# Apply VS Code settings
COPY ./config/settings.json .local/share/code-server/User/settings.json


# Port
ENV PORT=8080

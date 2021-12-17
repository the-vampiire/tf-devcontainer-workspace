# Note: You can use any Debian/Ubuntu based image you want. 
FROM mcr.microsoft.com/vscode/devcontainers/base:0-buster

# Options
ARG INSTALL_ZSH="true"
ARG UPGRADE_PACKAGES="true"
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
COPY library-scripts/*.sh /tmp/library-scripts/
RUN apt-get update \
    && /bin/bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# install AWS CLI
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends awscli

# Install Terraform, tflint, Packer
ARG TERRAFORM_VERSION=1.1.0
ARG TFLINT_VERSION=0.34.0
ARG PACKER_VERSION=1.7.8
RUN mkdir -p /tmp/docker-downloads \
    && curl -sSL -o /tmp/docker-downloads/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && curl -sSL -o /tmp/docker-downloads/tflint.zip https://github.com/wata727/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip \
    && curl -sSL -o /tmp/docker-downloads/packer.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
    && unzip /tmp/docker-downloads/terraform.zip \
    && unzip /tmp/docker-downloads/tflint.zip \
    && unzip /tmp/docker-downloads/packer.zip \
    && mv terraform tflint packer /usr/local/bin/ \
    && rm -rf /tmp/docker-downloads

# LAST - cleanup setup scripts
RUN rm -rf /tmp/library-scripts/

# create extensions dirs as non-root user 
# https://code.visualstudio.com/remote/advancedcontainers/avoid-extension-reinstalls
RUN mkdir -p \
        /home/$USERNAME/.vscode-server/extensions \
        /home/$USERNAME/.vscode-server-insiders/extensions \
    && chown -R $USERNAME \
        /home/$USERNAME/.vscode-server \
        /home/$USERNAME/.vscode-server-insiders
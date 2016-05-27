FROM jenkinsci/jenkins
MAINTAINER VNU Vacature Media <sysops@vnuvacaturemedia.nl>

# Switch to root for installing packages etc
USER root

RUN apt-get update

# Install packages required for builds
RUN apt-get install -y awscli python-pip ansible groff less make

# Install docker
RUN wget -qO- https://get.docker.com/ | sh

# add jenkins to docker
RUN usermod -aG docker jenkins

# Install docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

# Install docker-machine
RUN curl -L https://github.com/docker/machine/releases/download/v0.7.0/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine && \
chmod +x /usr/local/bin/docker-machine

# Install Terraform
RUN wget -q https://releases.hashicorp.com/terraform/0.6.16/terraform_0.6.16_linux_amd64.zip && unzip terraform_0.6.16_linux_amd64.zip -d /usr/local/bin/

# Clean up
RUN apt-get clean

# Switch back to the Jenkins user
USER jenkins

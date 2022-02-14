###
#
#	Yves Vindevogel (vindevoy)
#	2021-02-16
#
#	Debian based image running NGINX returns project information from an Ansible project
#
###


FROM vindevoy/debian-openresty:1.19.9.1-1-0

LABEL maintainer = "Yves Vindevogel (vindevoy) - yves.vindevogel@asynchrone.com"

ENV GIT_PROTOCOL=https
ENV GIT_URL=github.com/vindevoy/docker-debian-ansible-project-info.git  
ENV GIT_ACCESS_TOKEN=ADD_YOUR_TOKEN_HERE
ENV GIT_BRANCH=develop
ENV INVENTORY_FILE=src/sample/site.yml

# This automatically overwrites the existing files from the base image
COPY resources/* /root/

# Install extra software
RUN apt-get update -y
RUN apt-get upgrade -y

# Ansible is needed for ansible-inventory command
RUN apt-get install ansible --no-install-recommends -y

# JQ is a json parser, command line. Used for filtering the data for ansible-inventory
RUN apt-get install jq --no-install-recommends -y

# Git is needed to clone the repo that will be investigated
RUN apt-get install git --no-install-recommends -y

# Moreutils is needed for the sponge command we use in the script
RUN apt-get install moreutils --no-install-recommends -y

# Cleanup
RUN apt-get autoremove
RUN apt-get clean all

# Make sure scripts are executable
RUN chmod +x /root/*.sh 

# Running this on default port 80
EXPOSE 80

#CMD ["/bin/bash"]
CMD ["/bin/bash", "-c", "/root/openresty.sh"]





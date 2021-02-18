###
#
#	Yves Vindevogel (vindevoy)
#	2021-02-16
#
#	CentOS 10 based image running NGINX that executes a bash script and returns the output of it on port 3112
#
###
 
FROM vindevoy/debian10-nginx-lua-script:latest

LABEL maintainer="Yves Vindevogel (vindevoy) - yves.vindevogel@asynchrone.com"

ENV GIT_URL=https://URL.git
ENV GIT_BRANCH=master
ENV HOSTS_FILE=/var/opt/ansible/site.yml

# Copy is here for layer optimization
COPY resources/startup.sh /tmp/startup.sh
COPY resources/lua-server /tmp/lua-server 

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

RUN apt-get autoremove
RUN apt-get clean all

# Remove original scripts (from vindevoy/debian10-nginx-lua-script:latest) and copy new ones
RUN rm -f /etc/nginx/sites-available/lua-server
RUN rm -f /etc/nginx/sites-enabled/lua-server
RUN mv /tmp/lua-server /etc/nginx/sites-available/
RUN ln -sf /etc/nginx/sites-available/lua-server /etc/nginx/sites-enabled/lua-server 

# Run nginx as root because of git login (startup.sh must be run by root because it starts nginx)
# There should be a better way, maybe by executing git pull with sudo
RUN sed -i "s/user www-data;/user root;/g" /etc/nginx/nginx.conf

# This script is replaced by startup.sh
RUN rm -f /var/lua/lua.sh 

# The startup script will create the lua.sh file taking into account the ENV variables
RUN mv /tmp/startup.sh /opt/lua/startup.sh 
RUN chmod +x /opt/lua/startup.sh 

CMD ["/bin/bash", "-c", "/opt/lua/startup.sh"]
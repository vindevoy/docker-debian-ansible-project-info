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

ARG GIT_URL=https://oauth2:${GITLAB_ACCESS_TOKEN}@gitlab.com/asynchrone/infrastructure/user-infra.git
ARG GIT_BRANCH=develop

COPY resources/lua.sh /tmp/lua.sh
COPY resources/lua-server /tmp/lua-server 

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

# Clone the repo
RUN git clone $GIT_URL /var/opt/ansible 
RUN cd /var/opt/ansible && git checkout $GIT_BRANCH

# To review: Nginx makes uses these directories when the script is called
# It must have write access
RUN mkdir -p /var/www/.ansible/tmp 
RUN chmod 777 -R /var/www/.ansible 
RUN chmod 777 -R /var/www/lua

RUN rm -f /etc/nginx/sites-available/lua-server
RUN rm -f /etc/nginx/sites-enabled/lua-server
RUN mv /tmp/lua-server /etc/nginx/sites-available/
RUN ln -sf /etc/nginx/sites-available/lua-server /etc/nginx/sites-enabled/lua-server 

RUN rm -f /var/lua/lua.sh 
RUN mv /tmp/lua.sh /opt/lua/
RUN chmod +x /opt/lua/lua.sh 
RUN /opt/lua/lua.sh 

RUN apt-get autoremove
RUN apt-get clean all


#CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
CMD ["/bin/bash"]

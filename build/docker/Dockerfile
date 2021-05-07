FROM vindevoy/debian-openresty:latest

LABEL maintainer = "Yves Vindevogel (vindevoy) - yves.vindevogel@asynchrone.com"

ENV GIT_PROTOCOL=https
ENV GIT_URL=github.com/vindevoy/docker-debian-ansible-project-info.git
ENV GIT_ACCESS_TOKEN=ADD_YOUR_TOKEN_HERE
ENV GIT_BRANCH=develop
ENV INVENTORY_FILE=src/sample/site.yml

COPY resources/* /root/

RUN set -x && \ 
    apt-get update -y && \ 
    apt-get upgrade -y && \ 
    apt-get install ansible --no-install-recommends -y && \ 
    apt-get install jq --no-install-recommends -y && \ 
    apt-get install git --no-install-recommends -y && \ 
    apt-get install moreutils --no-install-recommends -y && \ 
    apt-get autoremove && \ 
    apt-get clean all && \ 
    chmod +x /root/*.sh

EXPOSE 80

CMD ["/bin/bash", "-c", "/root/openresty.sh"]

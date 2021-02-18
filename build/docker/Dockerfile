FROM vindevoy/debian10-nginx-lua-script:latest

LABEL maintainer="Yves Vindevogel (vindevoy) - yves.vindevogel@asynchrone.com"

ENV GIT_URL=https://URL.git
ENV GIT_BRANCH=master
ENV HOSTS_FILE=/var/opt/ansible/site.yml

COPY resources/startup.sh /tmp/startup.sh
COPY resources/lua-server /tmp/lua-server

RUN set -x && \ 
    apt-get update -y && \ 
    apt-get upgrade -y && \ 
    apt-get install ansible --no-install-recommends -y && \ 
    apt-get install jq --no-install-recommends -y && \ 
    apt-get install git --no-install-recommends -y && \ 
    apt-get install moreutils --no-install-recommends -y && \ 
    apt-get autoremove && \ 
    apt-get clean all && \ 
    rm -f /etc/nginx/sites-available/lua-server && \ 
    rm -f /etc/nginx/sites-enabled/lua-server && \ 
    mv /tmp/lua-server /etc/nginx/sites-available/ && \ 
    ln -sf /etc/nginx/sites-available/lua-server /etc/nginx/sites-enabled/lua-server && \ 
    sed -i "s/user www-data;/user root;/g" /etc/nginx/nginx.conf && \ 
    rm -f /var/lua/lua.sh && \ 
    mv /tmp/startup.sh /opt/lua/startup.sh && \ 
    chmod +x /opt/lua/startup.sh

CMD ["/bin/bash", "-c", "/opt/lua/startup.sh"]

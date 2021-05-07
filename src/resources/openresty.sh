#/bin/bash

echo "******************************"
echo "OPENRESTY ANSIBLE PROJECT INFO"
echo "******************************"
echo ""
echo "GIT REPO:" $GIT_PROTOCOL://$GIT_ACCESS_TOKEN@$GIT_URL 
echo "GIT BRANCH:" $GIT_BRANCH
echo "INVENTORY FILE:" $INVENTORY_FILE

#PATH=/usr/local/openresty/nginx/sbin:$PATH
#export PATH

ANSIBLE_DIR=/var/opt/ansible
export ANSIBLE_DIR
echo "ANSIBLE DIR:" $ANSIBLE_DIR

OUTPUT_DIR=/var/www/openresty
export OUTPUT_DIR
echo "OUTPUT DIR:" $OUTPUT_DIR

NGINX_BIN=/usr/local/openresty/nginx/sbin/nginx
export NGINX_BIN
echo "NGINX_BIN:" $NGINX_BIN

OPENRESTY_CONFIG=/root/openresty.conf
export OPENRESTY_CONFIG
echo "OPENRESTY CONFIG:" $OPENRESTY_CONFIG

echo ""
echo "******************************"
echo ""


# Create env.sh with all env vars, so we can re-use them later
# Although we run with -e and pass all the variables, they are not available to the scripts in nginx
# The below generated file provides a solution for that, use "source /root/env.sh"
echo "#!/bin/bash"                              >   /root/env.sh
echo ""                                         >>  /root/env.sh
echo "GIT_PROTOCOL="${GIT_PROTOCOL}             >>  /root/env.sh 
echo "GIT_URL="${GIT_URL}                       >>  /root/env.sh 
echo "GIT_ACCESS_TOKEN="${GIT_ACCESS_TOKEN}     >>  /root/env.sh 
echo "GIT_BRANCH="${GIT_BRANCH}                 >>  /root/env.sh 
echo "INVENTORY_FILE="${INVENTORY_FILE}         >>  /root/env.sh 
echo "ANSIBLE_DIR="${ANSIBLE_DIR}               >>  /root/env.sh 
echo "OUTPUT_DIR="${OUTPUT_DIR}                 >>  /root/env.sh 
echo "NGINX_BIN="${NGINX_BIN}                   >>  /root/env.sh 
echo "OPENRESTY_CONFIG="${OPENRESTY_CONFIG}     >>  /root/env.sh 
echo ""                                         >>  /root/env.sh
echo "export GIT_PROTOCOL"                      >>  /root/env.sh 
echo "export GIT_URL"                           >>  /root/env.sh 
echo "export GIT_ACCESS_TOKEN"                  >>  /root/env.sh 
echo "export GIT_BRANCH"                        >>  /root/env.sh 
echo "export INVENTORY_FILE"                    >>  /root/env.sh 
echo "export ANSIBLE_DIR"                       >>  /root/env.sh 
echo "export OUTPUT_DIR"                        >>  /root/env.sh 
echo "export NGINX_BIN"                         >>  /root/env.sh 
echo "export OPENRESTY_CONFIG"                  >>  /root/env.sh 
echo ""                                         >>  /root/env.sh


# Set this to avoid warnings when checking out
git config --global pull.rebase true

# Make clone of the Ansible repo
if [ -d $ANSIBLE_DIR ]
then
    rm -rf $ANSIBLE_DIR
fi

mkdir -p $ANSIBLE_DIR
git clone $GIT_PROTOCOL://$GIT_ACCESS_TOKEN@$GIT_URL $ANSIBLE_DIR
cd $ANSIBLE_DIR
git checkout $GIT_BRANCH

# Run OpenResty Nginx
$NGINX_BIN -g 'daemon off;' -c $OPENRESTY_CONFIG

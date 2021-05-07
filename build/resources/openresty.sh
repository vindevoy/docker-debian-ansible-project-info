#!/bin/bash

echo "******************************"
echo "OPENRESTY ANSIBLE PROJECT INFO"
echo "******************************"
echo ""
echo "GIT REPO:" $GIT_PROTOCOL://$GIT_ACCESS_TOKEN@$GIT_URL 
echo "GIT BRANCH:" $GIT_BRANCH
echo "INVENTORY FILE:" $INVENTORY_FILE

ANSIBLE_DIR=/var/opt/ansible
echo "ANSIBLE DIR:" $ANSIBLE_DIR

OUTPUT_DIR=/var/www/openresty
echo "OUTPUT DIR:" $OUTPUT_DIR

NGINX_BIN=/usr/local/openresty/nginx/sbin/nginx
echo "NGINX_BIN:" $NGINX_BIN

OPENRESTY_CONFIG=/root/openresty.conf
echo "OPENRESTY CONFIG:" $OPENRESTY_CONFIG

ENV_FILE=/root/env.sh 
echo "ENV_FILE CONFIG:" $ENV_FILE

echo ""
echo "******************************"
echo ""


# Create env.sh with all env vars, so we can re-use them later
# Although we run with -e and pass all the variables, they are not available to the scripts in nginx
# The below generated file provides a solution for that, use "source /root/env.sh"
echo "#!/bin/bash"                                  >   $ENV_FILE
echo ""                                             >>  $ENV_FILE
echo "export GIT_PROTOCOL="${GIT_PROTOCOL}          >>  $ENV_FILE
echo "export GIT_URL="${GIT_URL}                    >>  $ENV_FILE
echo "export GIT_ACCESS_TOKEN="${GIT_ACCESS_TOKEN}  >>  $ENV_FILE
echo "export GIT_BRANCH="${GIT_BRANCH}              >>  $ENV_FILE
echo "export INVENTORY_FILE="${INVENTORY_FILE}      >>  $ENV_FILE
echo "export ANSIBLE_DIR="${ANSIBLE_DIR}            >>  $ENV_FILE
echo "export OUTPUT_DIR="${OUTPUT_DIR}              >>  $ENV_FILE
echo "export NGINX_BIN="${NGINX_BIN}                >>  $ENV_FILE
echo "export OPENRESTY_CONFIG="${OPENRESTY_CONFIG}  >>  $ENV_FILE
echo ""                                             >>  $ENV_FILE

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

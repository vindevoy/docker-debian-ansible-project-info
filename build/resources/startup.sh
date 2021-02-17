#/bin/bash

if [ ! -d /var/opt/ansible ]
then
    mkdir -p /var/opt/ansible;
    git clone $GIT_URL /var/opt/ansible; 
fi

echo "#!/bin/bash"                  >   /opt/lua/lua.sh 
echo "cd /var/opt/ansible"          >>  /opt/lua/lua.sh
echo "git checkout" $GIT_BRANCH     >>  /opt/lua/lua.sh
echo "git pull origin" $GIT_BRANCH  >>  /opt/lua/lua.sh
echo "ansible-inventory -i" $HOSTS_FILE "--list | jq .all.children | jq '. | map(select(. != \"ungrouped\"))' | sponge /var/www/lua/output.json" >> /opt/lua/lua.sh

chmod +x /opt/lua/lua.sh

/opt/lua/lua.sh 

nginx -g "daemon off;"
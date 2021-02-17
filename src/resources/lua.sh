cd /var/opt/ansible
ansible-inventory -i ./inventories/machines/hosts --list | jq .all.children | jq '. | map(select(. != "ungrouped"))' | sponge /var/www/lua/output.json

#!/bin/bash

source /root/env.sh

HOSTS_FILE=hosts.json
GROUPS_FILE=groups.json
OUTPUT_FILE=hosts_groups.json
TMP_FILE=$OUTPUT_DIR/$OUTPUT_FILE.tmp

echo Generating output: $OUTPUT_DIR/$OUTPUT_FILE

echo "["                        >   $TMP_FILE
cat $OUTPUT_DIR/$HOSTS_FILE     >>  $TMP_FILE
echo ","                        >>  $TMP_FILE
cat $OUTPUT_DIR/$GROUPS_FILE    >>  $TMP_FILE
echo "]"                        >>  $TMP_FILE

#debug
#cat $TMP_FILE

cat $TMP_FILE | jq 'flatten' | sponge $OUTPUT_DIR/$OUTPUT_FILE
rm -f$TMP_FILE

#debug
#cat $OUTPUT_DIR/$OUTPUT_FILE

echo "Hosts+groups request done"
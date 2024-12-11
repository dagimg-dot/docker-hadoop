#!/bin/bash

echo "Starting resourcemanager!"
${HADOOP_HOME}/bin/yarn --config ${HADOOP_CONF_DIR} resourcemanager
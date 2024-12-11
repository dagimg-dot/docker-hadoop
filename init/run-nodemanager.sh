#!/bin/bash

echo "Starging nodemanager!"
${HADOOP_HOME}/bin/yarn --config ${HADOOP_CONF_DIR} nodemanager
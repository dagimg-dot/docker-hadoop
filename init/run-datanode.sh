#!/bin/bash

echo "Starting Datanode!"
${HADOOP_HOME}/bin/hdfs --config ${HADOOP_CONF_DIR} datanode
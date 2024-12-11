#!/bin/bash

echo "Formatting Namenode!"
${HADOOP_HOME}/bin/hdfs --config ${HADOOP_CONF_DIR} namenode -format ${CLUSTER_NAME}

echo "Starting Namenode!"
${HADOOP_HOME}/bin/hdfs --config ${HADOOP_CONF_DIR} namenode
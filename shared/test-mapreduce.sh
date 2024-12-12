#!/bin/bash

# Creamos directorios
hadoop fs -mkdir /test-mapreduce

# Subimos archivo
hadoop fs -put /shared/input/quijote.txt /test-mapreduce/

# Lanzamos mapreduce
yarn jar /opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar wordcount /test-mapreduce /test-mapreduce-output
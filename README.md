# docker-hadoophadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar wordcount /user/root/input.txt /user/root/output.txt

hdfs dfs -put /shared/input/input.txt /user/root
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar wordcount /user/root/input.txt /user/root/output
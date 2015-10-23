FROM leon1110/hadoop-base:2.1.0

MAINTAINER Leon Lee <lee.leon0519@gmail.com>

# move all confugration files into container
ADD files/start-ssh-serf.sh /root/

ENV HADOOP_INSTALL /usr/local/hadoop

RUN mkdir -p ~/hdfs/namenode && \ 
mkdir -p ~/hdfs/datanode && \
mkdir $HADOOP_INSTALL/logs && \
chmod +x ~/start-ssh-serf.sh && \
# format namenode
/usr/local/hadoop/sbin/start-all.sh && \
/usr/local/hadoop/bin/hdfs namenode -format && \
rm -fr /usr/local/hadoop/etc/hadoop/* && \
rm -fr /usr/local/hbase/conf/*


EXPOSE 22 7373 7946 9000 50010 50020 50070 50075 50090 50475 8030 8031 8032 8033 8040 8042 8060 8088 50060

CMD '/root/start-ssh-serf.sh'; 'bash'

FROM leon1110/serf-dnsmasq:2.1.0

MAINTAINER Leon Lee <lee.leon0519@gmail.com>

# install openssh-server
RUN apt-get install -y openssh-server

## install jdk-1.7.0_80 hadoop-2.5.2 hbase-1.1.2 scala-2.12.0 spark-2.5.1 pig from web 
# RUN curl -Lso /usr/local/hadoop-2.5.2.tar.gz http://mirrors.cnnic.cn/apache/hadoop/common/hadoop-2.5.2/hadoop-2.5.2.tar.gz && \
#tar zxvf /usr/local/hadoop-2.5.2.tar.gz -C /usr/local && \
#rm -fr /usr/local/hadoop-5.3.2.tar.gz && \
#curl -Lso /usr/local/hbase-1.1.2.tar.gz https://www.apache.org/dist/hbase/1.1.2/hbase-1.1.2-bin.tar.gz && \
#tar zxvf /usr/local/hbase-1.1.2.tar.gz -C /usr/local && \
#rm -fr /usr/local/hbase-1.1.2.tar.gz
# ......

## install jdk-1.7.0_80 hadoop-2.5.2 hbase-1.1.2 scala-2.12.0 spark-2.5.1 pig from local files (hadoop-base files directories)
ADD files/jdk-7u80-linux-x64.tar.gz /usr/local
ADD files/hadoop-2.5.2.tar.gz /usr/local
ADD files/hbase-1.1.2-bin.tar.gz /usr/local
ADD files/scala-2.12.0-M3.tgz /usr/local
ADD files/spark-1.5.1-bin-hadoop2.4.tgz /usr/local


# Export to system environment path			
ENV JAVA_HOME /usr/local/jdk1.7.0_80 
ENV PATH $PATH:$JAVA_HOME/bin

#configure ssh free key access
ADD files/ssh_config /usr/local/
ADD files/bashrc /usr/local/

RUN mkdir /var/run/sshd && \
ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
mv /usr/local/ssh_config ~/.ssh/config && \
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

#install hadoop 2.5.2
RUN ln -s /usr/local/hadoop-2.5.2 /usr/local/hadoop && \
ln -s /usr/local/hbase-1.1.2 /usr/local/hbase && \ 
ln -s /usr/local/scala-2.12.0-M3 /usr/local/scala && \ 
ln -s /usr/local/spark-1.5.1-bin-hadoop2.4 /usr/local/spark && \ 
mv /usr/local/bashrc ~/.bashrc

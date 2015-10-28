#!/bin/bash

tag="2.1.0"

FILEDIR=`pwd`

<<<<<<< HEAD
port_mapping="-p 50070:50070 -p 8088:8088"


=======
>>>>>>> f232f678ef191caae703de7c2dbad2f66e4260fd
function resize_cluster() {
	echo -e "[**Info]: Resizing Cluster Nodes to: \033[31m"$1"\033[0m"
	# Modify hadoop config file "slaves" and hbase file "regionservers" and "hbase-site.xml"
	zk_value="master"
	echo "master" > $FILEDIR/conf/hadoop/slaves
	echo "master" > $FILEDIR/conf/hbase/regionservers
	i=1
	while [ $i -lt $1 ]
	do
		echo "slave$i" >> $FILEDIR/conf/hadoop/slaves
		echo "slave$i" >> $FILEDIR/conf/hbase/regionservers
		zk_value=`echo $zk_value","slave$i`
		((i++))
	done
	sed -i -r "s@master\,slave[0-9]+.*(<\/value>)@$zk_value\1@g" $FILEDIR/conf/hbase/hbase-site.xml
}


function get_current_size() {
	curr_size=`cat $FILEDIR/conf/hadoop/slaves | wc -l`
#	curr_size=`awk 'BEGIN{printf "%d\n", ('$curr_size'+1)}'`
}


function stop_container() {
	docker ps -a | awk '{print $NF}' | grep -v "NAMES" | while read line 
	do
		if [[ $line =~ (^slave[0-9]+|^master$) ]]; then
			docker stop $line  > /dev/null && docker rm -f $line > /dev/null
		fi
	done
}


function start_container() {
	# delete old master container and start new master container
	echo "[**Info]: Starting master container..."
<<<<<<< HEAD
	docker run -d -t --dns 127.0.0.1 -P --name master -h master -v $FILEDIR/conf/hadoop/:/usr/local/hadoop/etc/hadoop/ -v $FILEDIR/conf/hbase/:/usr/local/hbase/conf/ -w /root $port_mapping leon1110/hadoop-node:$tag &> /dev/null
=======
	docker run -d -t --dns 127.0.0.1 -P --name master -h master -v $FILEDIR/conf/hadoop/:/usr/local/hadoop/etc/hadoop/ -v $FILEDIR/conf/hbase/:/usr/local/hbase/conf/ -w /root leon1110/hadoop-node:$tag &> /dev/null
>>>>>>> f232f678ef191caae703de7c2dbad2f66e4260fd

	# get the IP address of master container
	FIRST_IP=$(docker inspect --format="{{.NetworkSettings.IPAddress}}" master)

	# delete old slave containers and start new slave containers
	i=1
	while [ $i -lt $1 ]
	do
		echo "[**Info]: starting slave$i container..."
		docker run -d -t --dns 127.0.0.1 -P --name slave$i -h slave$i -v $FILEDIR/conf/hadoop/:/usr/local/hadoop/etc/hadoop/ -v $FILEDIR/conf/hbase/:/usr/local/hbase/conf/ -e JOIN_IP=$FIRST_IP leon1110/hadoop-node:$tag &> /dev/null
		((i++))
	done 
}


function start_cluster() {
	echo -e "Please specify the nodes number you would like to start in the cluster: \033[32m"
	read N
	echo -e "\033[0m\c"
	get_current_size
	echo -e "[**Info]: Current nodes: \033[31m "$curr_size"\033[0m"
	echo -e "[**Info]: You are setting nodes to: \033[31m"$N"\033[0m" 


	if [ $N -lt 2 ]; then
		echo "Cluster Size should be greater than one nodes. Exiting..."
		exit
	elif [ $curr_size -eq $N ];then
		echo -e "[**Info]: Starting Cluster with Nodes \033[31m"$curr_size"\033[0m"
		stop_container
		start_container $N
	else
		stop_container
		resize_cluster $N
		start_container $N
	fi
	docker exec -it master bash
}


function remove_images() {
	stop_container
	echo "Removing leon1110/$1"
	docker rmi leon1110/$1:$tag
}


function docker_build() {
 	stop_container
	if [[ $1 =~ (^serf-dnsmasq$|^all-images$|^remove-all$) ]]; then
		echo "[**Info]: Removing and rebuilding all images"
		for image in hadoop-node hadoop-base serf-dnsmasq
		do
			remove_images $image
		done
		if [[ $1 = "remove-all" ]];then
			exit
		fi
		for image in serf-dnsmasq hadoop-base hadoop-node
		do
			echo "Building $image"
			cd $image
			docker build --rm -t leon1110/$image:$tag .
			cd ../
		done
	elif [[ $1 = "hadoop-base" ]]; then
		echo "[**Info]: Removing and rebuilding hadoop-base and hadoop-node images"
		for image in hadoop-node hadoop-base
		do
			remove_images $image
		done
		for image in hadoop-base hadoop-node
		do
			echo "Building $image"
			cd $image
			docker build --rm -t leon1110/$image:$tag .
			cd ../
		done
	elif [[ $1 = "hadoop-node" ]]; then
		echo "[**Info]: Removing and rebuilding hadoop-node images"
			remove_images "hadoop-node"
			echo "Building hadoop-node"
			cd hadoop-node
			docker build --rm -t leon1110/hadoop-node:$tag .
			cd ../
	else
		echo "[**Error]: Error Option Captured, Exiting..."
		exit
	fi
	echo "[**Info]: Setting to default cluster size: 3"
	resize_cluster 3
}


function build_images() {
	echo -e "\033[0m\c"
	echo -e "Please specify the images you would like to build, options are provided: \033[32m"
	echo "1. serf-dnsmasq"
	echo "2. hadoop-base"
	echo "3. hadoop-node"
	echo "4. all-images"
	echo -e "\033[32m\c"
	read opt
	echo -e "\033[0m\c"

	case "$opt" in
		[1] ) (docker_build "serf-dnsmasq");;
		[2] ) (docker_build "hadoop-base");;
		[3] ) (docker_build "hadoop-node");;
		[4] ) (docker_build "all-images");;
		*) echo "Wrong Option. Exit!!!";;
	esac
}

# Contrain to run this script in root directory
if [[ $0 =~ (^\.\/ecosystem-tools.sh$) ]]; then
	echo -e "\033[0m\c"
	echo "Please specify one of the following option."
	echo "1. Build Hadoop Ecosystem Docker Images."
	echo "2. Start Hadoop Ecosystem on Docker.(Default Nodes: 3)"
	echo "3. Remove All Related Images."
	echo "4. Stop & Remove All Hadoop Containers."
	echo -e "\033[32m\c"
	read num
	echo -e "\033[0m\c"

	case "$num" in
		[1] ) (build_images);;
		[2] ) (start_cluster);;
		[3] ) (docker_build "remove-all");;
		[4] ) (stop_container);;
		*) echo "Wrong Option. Exit!!!";;
	esac
else
	echo "You should execute the script in root of this project."
	exit
fi

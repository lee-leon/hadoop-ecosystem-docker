

# **Hadoop Ecosystem Docker**
![hadoop-ecosystem-docker-logo](http://lee-leon.github.io/images/github/logo/hadoop-ecosystem-docker-logo.jpg)
------


## **Introduction**
This project aims at making a handy tool that can quickly deploy distributed computing adn storing platforms (Hadoop Ecosystem) on docker containers. It can svae developers developing time and enable them to focus on the code works.

Right now, Hadoop Ecosystem Platforms includes:
> * Hadoop (Version 2.5.2)
> * HBase (Version 1.1.2)
> * Spark (Version 1.5.1)
> * Pig (Version 0.15.0)

It can adjust the hadoop cluster nodes according to your wish, the default nodes are made to 3. 


------
## **Usage**
```shell
git clone https://github.com/lee-leon/hadoop-ecosystem-docker.git
cd hadoop-ecosystem-docker
./ecosystem-tools.sh
```
**Four options are provided as following:**
![ecosystem-tools-options-logo](http://lee-leon.github.io/images/github/hadoop-ecosystem-docker/1.png)

Choose one to complete the deployment.

------
## **Prerequisite**
| Node           | IP            |  Software  | Version  |
| --------       | -----:        | :----:     | ---------|
| Master         |192.168.3.101  | Docker     | 1.8.2    |
| ....           |               |            |          |
| ....           |               |            |          


------
## **Todo**
- [X] Deploy hadoop cluster on local docker platform
- [X] Initiate cluster with startup scripts
- [ ] Orchestrate clusters on different nodes
- [ ] Integrate with Kubernetes for unified management and deployment


------
## **License**
The MIT License (MIT)

Copyright (c) 2015 Leon Lee \<lee.leon0519@gmail.com\>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

------

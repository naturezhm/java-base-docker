# docker基础镜像 - java基础镜像 debug
#
# date 2019-11-27
# author zhangming
# version 1.1

FROM centos:7.8.2003
LABEL maintainer="naturezhm@gmail.com"

# 文件名，升级的时候，覆盖setup的新版本，然后设置此处文件名即可
ARG MAVEN_FILE_NAME=apache-maven-3.6.3-bin.tar.gz
ARG JDK_FILE_NAME=jdk-8u271-linux-x64.tar.gz

ENV JDK_VERSION=1.8.271 \
    MAVEN_VERSION=3.6.3 \
    JAVA_HOME=/usr/local/jdk \
    MAVEN_HOME=/usr/local/maven


ENV PATH=${JAVA_HOME}/bin:${MAVEN_HOME}/bin:$PATH 

COPY setup/ /usr/local/src/

RUN set -ex \
    && mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup \
    && mv /usr/local/src/Centos-7.repo /etc/yum.repos.d/CentOS-Base.repo \
    && mv /usr/local/src/epel.repo /etc/yum.repos.d/epel.repo \
    && yum clean all \
    && yum makecache && yum update -y \
    && yum install -y procps zip unzip curl bash wget net-tools openssl sysstat lsof epel-release htop traceroute mtr nc tcpdump lrzsz nload jq iftop bind-utils telnet rsync git openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel gcc automake autoconf libtool make  libffi-devel \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' >/etc/timezone \
    && localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8 \
    && mkdir -p /opt/settings \
    && mkdir -p /opt/data \
    && mkdir -p /app \
    && mkdir /app/logs


ENV LANG=zh_CN.UTF-8 \
    CHARSET=UTF-8

# 开始安装基础运行环境 jdk maven
RUN cd /usr/local \
    && mkdir jdk maven arthas scripts \
    && tar -xzvf /usr/local/src/${JDK_FILE_NAME} -C ${JAVA_HOME} --strip-components=1 \
    && tar -xzvf /usr/local/src/${MAVEN_FILE_NAME} -C ${MAVEN_HOME} --strip-components=1 

# 安装 arthas
COPY --from=hengyunabc/arthas:latest /opt/arthas /usr/local/arthas

# 安装 useful-script 运维脚本
RUN   cd /usr/local/scripts \
    && wget --no-check-certificate https://github.com/oldratlee/useful-scripts/archive/release.zip \
    && unzip release.zip

# clean
RUN rm -rf /usr/local/src/ \
    && yum clean all 


ENTRYPOINT [ "tail", "-f" ]
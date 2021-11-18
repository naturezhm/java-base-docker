# docker基础镜像 - Python3的基础镜像
#
# date 2019-11-27
# author naturezhm
# version 1.0

FROM centos:7.8.2003
LABEL maintainer="naturezhm@gmail.com"

# 文件名，升级的时候，覆盖setup的新版本，然后设置此处文件名即可
ARG PYTHON_FILE_NAME=Python-3.9.1.tar.xz

ENV PYTHON_VERSION=3.9.1 \
    PYTHON_HOME=/usr/local/python3

COPY setup/ /usr/local/src/

RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup \
    && mv /usr/local/src/Centos-7.repo /etc/yum.repos.d/CentOS-Base.repo \
    && mv /usr/local/src/epel.repo /etc/yum.repos.d/epel.repo \
    && yum clean all \
    && yum makecache && yum update -y \
    && yum install -y procps zip unzip curl bash wget net-tools openssl sysstat lsof epel-release htop traceroute mtr nc tcpdump lrzsz nload jq iftop bind-utils telnet rsync git openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel gcc automake autoconf libtool make  libffi-devel which \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' >/etc/timezone \
    && localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8 \
    && mkdir -p /opt/settings \
    && mkdir -p /opt/data \
    && mkdir -p /app \
    && mkdir /app/logs


ENV LANG=zh_CN.UTF-8 \
    CHARSET=UTF-8

# 开始安装基础运行环境 python
RUN cd /usr/local \
    && mkdir scripts python3 \
    && tar -xJvf /usr/local/src/${PYTHON_FILE_NAME} -C ${PYTHON_HOME} --strip-components=1

# 安装 python
RUN cd ${PYTHON_HOME} \
    && ./configure --prefix=/usr/local/python3 \
    && make && make install \
    && ln -s /usr/local/python3/bin/python3 /usr/bin/python3

# 安装 pip
RUN python3 /usr/local/src/get-pip.py \
    && ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3 \
    && python /usr/local/src/get-pip.py
    



# clean
RUN rm -rf /usr/local/src/ \
    && yum clean all 


ENTRYPOINT [ "tail", "-f" ]
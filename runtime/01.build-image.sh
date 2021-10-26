#!/bin/bash
# 用来build 镜像并上传到 仓库

# 镜像版本
IMAGE_NAME=java-base
IMAGE_PATH=bradyzm
IMAGE_VERSION=1.2.3-debug

docker build -t ${IMAGE_PATH}/${IMAGE_NAME}:${IMAGE_VERSION} -f Dockerfile .

if [ "$?" != 0 ] ; then
    printf "本地镜像build失败 \n" ;
    exit 1;
fi

printf "======  请输入docker的镜像仓库的登录密码  ====== \n"
docker login 

docker push ${IMAGE_PATH}/${IMAGE_NAME}:${IMAGE_VERSION} 

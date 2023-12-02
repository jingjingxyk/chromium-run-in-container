
IMAGE=wenba100xie/chromium:debian-11-20230805T0029Z

ALIYUN_IMAGE=registry.cn-beijing.aliyuncs.com/jingjingxyk-public/app:chromium-debian-11-20230805T0029Z

docker tag ${IMAGE} ${ALIYUN_IMAGE}

docker push ${ALIYUN_IMAGE}


registry.cn-beijing.aliyuncs.com/jingjingxyk-public/app:chromium-debian-11-20230804T0445Z
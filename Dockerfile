#基础镜像
FROM java:8
#镜像的制作人
MAINTAINER mengqizhang
ENV APP_NAME="nacos-provider-b-0.0.1"
#此处必须这么指定，ARG参数在最终的ENTRYPOINT执行时会出现问题
ENV FILE_NAME="nacos-provider-b-0.0.1.jar"
ENV WORK_DIR="/home/mqz/nacos-project/${APP_NAME}"
ENV JAVA_MS="1G"
ENV JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Dlog4j.defaultInitOverride=true -Dorg.apache.tomcat.util.http.ServerCookie.ALLOW_EQUALS_IN_VALUE=true -Dorg.apache.tomcat.util.http.ServerCookie.ALLOW_HTTP_SEPARATORS_IN_V0=true -server  -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m -Xmn256m -XX:SurvivorRatio=10 -XX:+UseConcMarkSweepGC -XX:CMSMaxAbortablePrecleanTime=5000 -XX:+CMSClassUnloadingEnabled -XX:CMSInitiatingOccupancyFraction=80 -XX:+UseCMSInitiatingOccupancyOnly -XX:+ExplicitGCInvokesConcurrent -Dsun.rmi.dgc.server.gcInterval=2592000000 -Dsun.rmi.dgc.client.gcInterval=2592000000 -XX:ParallelGCThreads=4 -Djava.awt.headless=true -Dsun.net.client.defaultConnectTimeout=10000 -Dsun.net.client.defaultReadTimeout=30000  -Dfile.encoding=utf-8"
RUN mkdir -p  ${WORK_DIR}
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
WORKDIR ${WORK_DIR}
# 把可执行jar包复制到基础镜像的根目录下
COPY target/nacos-provider-b-0.0.1.jar nacos-provider-b-0.0.1.jar
#声明了容器应该打开的端口并没有实际上将它打开
EXPOSE 9998
#健康检查
HEALTHCHECK --start-period=60s --interval=60s --timeout=60s --retries=10 CMD curl --fail localhost:9998/actuator/health || exit 1
#指定容器启动时要执行的命令，但如果存在CMD指令，CMD中的参数会被附加到ENTRYPOINT指令的后面
ENTRYPOINT ["sh","-c","java ${JAVA_OPTS} -jar nacos-provider-b-0.0.1.jar"]
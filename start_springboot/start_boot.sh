#!/bin/bash

if [[ ! -f demo.jar ]]; then
	echo "项目不存在..退出"
	exit 1
fi
#参数说明：
# -Xms256m 最小堆内存 -Xmx256m 最大堆内存 -Xmn96m 年轻代大小（官方建议堆内存3/8）-Xss512k:设置每个线程的堆栈大小
# -XX:MetaspaceSize=128m 元空间大小 -XX:MaxMetaspaceSize=128m 元空间最大容量 -XX:SurvivorRatio=8 s区和e区为8:2
#
# 如果开启了-XX:+UseCompressedOops及-XX:+UseCompressedClassesPointers（默认是开启），则UseCompressedOops会
# 使用32位的偏移来代表java对象的引用，而UseCompressedClassPointers则使用32位的偏移来代表64位进行中类指针；可以使用
# CompressedClassSpaceSize来设置这块的空间大小
GC_OPTS="-Xloggc:/app_log/app_name/gc_log/gc.log -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+PrintGCApplicationStoppedTime -XX:+PrintGCApplicationConcurrentTime -XX:+PrintHeapAtGC -XX:UseG1GC"
JMX_OPTS="-Djava.rmi.server.hostname=47.101.68.18 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=20019 -Dcom.sun.management.jmxremote.rmi.port=20010 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
JAVA_OPTS="-server -Xms256m -Xmx256m -Xmn96m -Xss512k -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=128m -XX:SurvivorRatio=8 -XX:+UseCompressedClassPointers -XX:+UseCompressedOops -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/app_log/app_name/gc_log/heapdump.hprof $GC_OPTS $JMX_OPTS"

# 后台启动 springboot 项目
nohup java ${JAVA_OPTS} -jar  demo.jar >> /app_log/app_name/app_log/start.log &

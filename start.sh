#!/bin/sh

if [ -z "$SERVICE_PORT" ]; then
  SERVICE_PORT=5556
fi

if [ -z "$JVM_OPTS" ]; then
  JVM_OPTS="-Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.port=5555"
fi

JMX_HOST=${JMX_HOST:-localhost} JMX_PORT=${JMX_PORT:-5555} gomplate -f /opt/jmx_exporter/config.yml.template > /opt/jmx_exporter/config.yml

java $JVM_OPTS -jar /opt/jmx_exporter/jmx_prometheus_httpserver-$VERSION-jar-with-dependencies.jar $SERVICE_PORT /opt/jmx_exporter/config.yml


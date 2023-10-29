#!/usr/bin/env bash

if [ -z "$(ls -A $CRAC_FILES_DIR)" ]; then
  echo 128 > /proc/sys/kernel/ns_last_pid; java -Dspring.context.checkpoint=onRefresh -XX:CRaCCheckpointTo=$CRAC_FILES_DIR -jar /opt/app/app.jar
else
  java -XX:CRaCRestoreFrom=$CRAC_FILES_DIR&
  PID=$!
  trap "kill $PID" SIGINT SIGTERM
  wait $PID
fi
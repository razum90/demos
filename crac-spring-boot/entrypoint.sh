#!/usr/bin/env bash
# Here, simply start your application
java -Dspring.context.checkpoint=onRefresh -XX:CRaCCheckpointTo=$CRAC_FILES_DIR -jar /opt/app/app.jar
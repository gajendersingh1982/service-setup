#!/usr/bin/env bash

export ENVIRONMENT='production'

# MailTrain
export MAILTRAIN_ON='OFF'
export MAILTRAIN_ACCESS_TOKEN='mailtrain_toke'
export MAILTRAIN_CLIENTID='mailtrain_ID'

export SECRET_KEY_BASE='keybase'

# Database
export SPRING_DATASOURCE_DRIVER_CLASS_NAME='com.mysql.jdbc.Driver'
export SPRING_DATASOURCE_PASSWORD='${db_password}'
export SPRING_DATASOURCE_URL='url'
export SPRING_DATASOURCE_USERNAME='gbadm'

# AWS - We will use role in place of AWS Creds

export forcereload='2'
export XRAY_ENABLED=''

export SPRING_DATASOURCE_TEST_ON_BORROW='true'
export GRADLE_HOME='/usr/local/gradle'
export JAVA_HOME='/usr/lib/jvm/java'
export JDBC_CONNECTION_STRING=''
export M2='/usr/local/apache-maven/bin'
export M2_HOME='/usr/local/apache-maven'
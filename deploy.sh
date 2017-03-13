#!/usr/bin/env bash

##
# Deploy script to deploy your app to "${HOME}/app/${APP_NAMW}"
# Run this script with simple "./deploy.sh"
##

# IMPORTANT: CUSTOMIZE YOUR APP HERE!!!!!!
APP_NAME=
VERSION=0.0.1-SNAPSHOT

# Check customized variables
[[ -z ${APP_NAME} ]] && { echo "FATAL: 'APP_NAME' not set"; exit 1; }

# Head to script dir
cd `dirname "$0"`
_X=$(pwd)

# Dirs in contrast
DEPLOY_DIR="${HOME}/app/${APP_NAME}"
JARFILE="$_X/build/libs/${APP_NAME}-${VERSION}.jar"
LAUNCH_SCRIPT="${DEPLOY_DIR}/${APP_NAME}.sh"
TEMPLATE_SCRIPT="${HOME}/script/app.sh"

# Build with gradle
gradle build || { echo 'ERROR: gradle build task failed'; exit 1; }

# Settle the deploy dir if not settled
if [[ -d ${DEPLOY_DIR} ]]; then
  echo 'INFO: deploy dir found' 
else
  mkdir -p ${DEPLOY_DIR} && echo 'INFO: deploy dir settled' \
    || { echo 'ERROR: unable to settle deploy dir'; exit 1; }
fi

if [[ -f ${LAUNCH_SCRIPT} ]]; then
  echo 'INFO: launch script found'
else
  if [[ -x ${TEMPLATE_SCRIPT} ]]; then
    sed -e "s/APP_NAME=/APP_NAME=${APP_NAME}/g" -e "s/VERSION=/VERSION=${VERSION}/g" ${TEMPLATE_SCRIPT} > ${LAUNCH_SCRIPT} \
      && echo 'INFO: launch script generated' || { echo 'ERROR: unable to generate launch script'; exit 1; }
    chmod +x ${LAUNCH_SCRIPT}
  else
    echo "ERROR: template script 'app.sh' not exist or not executable"
    exit 1
  fi
fi

# Stop the app
${LAUNCH_SCRIPT} stop

# Move jar file to deploy directory
cp ${JARFILE} ${DEPLOY_DIR}/ && echo 'INFO: jar file settled' || { echo 'ERROR: unable to settle jar file'; exit 1; }

# Start the app
${LAUNCH_SCRIPT} start || { echo 'ERROR: unable to start the app'; exit 1; }

# Check if the app is running
${LAUNCH_SCRIPT} status || { echo "ERROR: app not running, try 'tail -fn 800 /tmp/${APP_NAME}.log' for more info"; exit 1; }

# Tail the log
tail -fn 800 ${DEPLOY_DIR}/logs/application.log || echo "try 'tail -fn 800 ${DEPLOY_DIR}/logs/application.log' by yourself"

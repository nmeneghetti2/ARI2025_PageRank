#!/bin/bash

# on failure, terminate the script immediately
set -e

# determine original username 
# (in a sudo session, this returns the user that originally invoked sudo,
# in a regular user-land session, this retuns the regula ${USER})
ORIG_USER=${SUDO_USER-${USER}}

# Determine the script's absolute path
SCRIPTSDIR_ABS_PATH=$(readlink -f ${BASH_SOURCE[0]})
SCRIPTSDIR_ABS_PATH=$(dirname ${SCRIPTSDIR_ABS_PATH})

# Determine the project's root path
PROJECT_ROOT_ABS_PATH=$(readlink -f ${SCRIPTSDIR_ABS_PATH}/../)

# Determine commonly used directories
DATADIR_ABS_PATH=$(readlink -f ${PROJECT_ROOT_ABS_PATH}/data)
OUTPUTDIR_ABS_PATH=$(readlink -f ${PROJECT_ROOT_ABS_PATH}/output)
#echo "${PROJECT_ROOT_ABS_PATH}"

# make sure this is run with sudo
if [ "$EUID" -ne 0 ]
  then echo "WARNING: You probably want to run this as root"
fi

DISTRO="reproenv"

# define the image's name
DOCKER_IMG_NAME="pagerank_reproenv_docker_img"
echo "Building docker image ${DOCKER_IMG_NAME}"

# build the image
cwd=$(pwd)
cd ${PROJECT_ROOT_ABS_PATH}
docker build  --no-cache -t ${DOCKER_IMG_NAME} -f ${SCRIPTSDIR_ABS_PATH}/dockerfiles/${DISTRO}/Dockerfile .
cd ${cwd}

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
PROJECT_ROOT_ABS_PATH_HASH=$(echo ${PROJECT_ROOT_ABS_PATH} | md5sum | cut -d' ' -f 1 | cut -c 25-32) 

# Determine the project's root path
PROJECT_ROOT_ABS_PATH=$(readlink -f ${SCRIPTSDIR_ABS_PATH}/../)

# Determine commonly used directories
DATADIR_ABS_PATH=$(readlink -f ${PROJECT_ROOT_ABS_PATH}/data)
OUTPUTDIR_ABS_PATH=$(readlink -f ${PROJECT_ROOT_ABS_PATH}/output)

# make sure this is run with sudo
if [ "$EUID" -ne 0 ]
  then echo "WARNING: You probably want to run this as root"
fi

DISTRO="reproenv"

# define the image's name
DOCKER_IMG_NAME="pagerank_reproenv_docker_img" 
DOCKER_CONT_NAME="pagerank_reproenv_container_${ORIG_USER}${PROJECT_ROOT_ABS_PATH_HASH}"
#MOUNT_OPTIONS="type=bind,source=${PROJECT_ROOT_ABS_PATH},target=/pagerank"
MOUNT_OPTIONS="${PROJECT_ROOT_ABS_PATH}:/pagerank:z"

#echo $MOUNT_OPTIONS
#echo $DOCKER_CONT_NAME

docker run -v ${MOUNT_OPTIONS} --name ${DOCKER_CONT_NAME} --detach --tty ${DOCKER_IMG_NAME} /bin/bash

echo "Run \"docker exec -it ${DOCKER_CONT_NAME} bash\" to access the container."

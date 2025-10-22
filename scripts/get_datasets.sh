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

# download the datasets
cwd=$(pwd)
cd ${DATADIR_ABS_PATH}
cat datasets.txt | parallel --gnu "wget --tries=0 --wait=5 --random-wait {} 2>&1 | tee {/.}.wget.log"
unrar -y x Orkut.rar
unrar -y x UKDomain.rar
unrar -y x Friendster.rar

cd ${cwd}

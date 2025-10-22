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

mkdir -p $DATADIR_ABS_PATH
mkdir -p $OUTPUTDIR_ABS_PATH


################################################################
# Orkut Dataset
################################################################

#Proposed 
#CUR_Trans
python3 CUR.py CUR_Trans  $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/CUR_TransOrkut.txt 0.1 1000 0.1 2>&1 | tee $OUTPUTDIR_ABS_PATH/CUR_TransOrkut.log
#T2
python3 T2.py $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/T2Orkut.txt 0.1 2>&1 | tee $OUTPUTDIR_ABS_PATH/T2Orkut.log

#Baselines
#OK
python3 Competitors.py  GroundTruth $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/GroundTruthOrkut.txt 2>&1 | tee $OUTPUTDIR_ABS_PATH/GroundTruthOrkut.log
#OK
python3 Competitors.py  DSPI $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/DSPIOrkut.txt 0.1 0.1 2>&1 | tee $OUTPUTDIR_ABS_PATH/DSPIOrkut.log
#FAILS
python3 Competitors.py  ApproxRank $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/ApproxRankOrkut.txt 0.1 1000 2>&1 | tee $OUTPUTDIR_ABS_PATH/ApproxRankOrkut.log
#OK
python3 Competitors.py  LPRAP $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/LPRAPOrkut.txt 100 0.1 0.1 2>&1 | tee $OUTPUTDIR_ABS_PATH/LPRAPOrkut.log



################################################################
# UKDomain
################################################################

#Proposed 
#CUR_Trans
python3 CUR.py CUR_Trans  $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/CUR_TransUKDomain.txt 0.1 1000 0.1 2>&1 | tee $OUTPUTDIR_ABS_PATH/CUR_TransUKDomain.log
#T2
python3 T2.py $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/T2UKDomain.txt 0.1 2>&1 | tee $OUTPUTDIR_ABS_PATH/T2UKDomain.log

#Baselines
# FAILS
python3 Competitors.py  GroundTruth $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/GroundTruthUKDomain.txt 2>&1 | tee $OUTPUTDIR_ABS_PATH/GroundTruthUKDomain.log
# FAILS
python3 Competitors.py  DSPI $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/DSPIUKDomain.txt 0.1 0.1 2>&1 | tee $OUTPUTDIR_ABS_PATH/DSPIUKDomain.log
# FAILS
python3 Competitors.py  ApproxRank $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/ApproxRankUKDomain.txt 0.1 1000 2>&1 | tee $OUTPUTDIR_ABS_PATH/ApproxRankUKDomain.log
# FAILS
python3 Competitors.py  LPRAP $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/LPRAPUKDomain.txt 100 0.1 0.1 2>&1 | tee $OUTPUTDIR_ABS_PATH/LPRAPUKDomain.log




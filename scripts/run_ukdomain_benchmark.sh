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
# UKDomain Dataset  (86edb286ef5b735231a08effd6331579 UKDomain.txt)
################################################################

# Baseline - Networkit
python3 Competitors.py  GroundTruth $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/GroundTruthUKDomain.txt 2>&1 | tee $OUTPUTDIR_ABS_PATH/GroundTruthUKDomain.log

# Baseline - ApproxRank

#sampled edges (%)  0.1
python3 Competitors.py  ApproxRank $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/ApproxRankUKDomain01.txt 0.02 105153952 2>&1 | tee $OUTPUTDIR_ABS_PATH/ApproxRankUKDomain01.log

#sampled edges (%)  0.3
python3 Competitors.py  ApproxRank $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/ApproxRankUKDomain03.txt 0.04 105153952 2>&1 | tee $OUTPUTDIR_ABS_PATH/ApproxRankUKDomain03.log

#sampled edges (%)  0.5
python3 Competitors.py  ApproxRank $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/ApproxRankUKDomain05.txt 0.06 105153952 2>&1 | tee $OUTPUTDIR_ABS_PATH/ApproxRankUKDomain05.log

#sampled edges (%)  0.7
python3 Competitors.py  ApproxRank $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/ApproxRankUKDomain07.txt 0.07 105153952 2>&1 | tee $OUTPUTDIR_ABS_PATH/ApproxRankUKDomain07.log

#sampled edges (%)  1.0
python3 Competitors.py  ApproxRank $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/ApproxRankUKDomain10.txt 0.09 105153952 2>&1 | tee $OUTPUTDIR_ABS_PATH/ApproxRankUKDomain10.log


# Baseline - LPRAP

#sampled edges (%)  0.1
python3 Competitors.py LPRAP $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/LPRAPUKDomain01.txt 1000 0.001 1e-10 2>&1 | tee $OUTPUTDIR_ABS_PATH/LPRAPUKDomain01.log

#sampled edges (%)  0.3
python3 Competitors.py LPRAP $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/LPRAPUKDomain03.txt 1000 0.003 1e-10 2>&1 | tee $OUTPUTDIR_ABS_PATH/LPRAPUKDomain03.log

#sampled edges (%)  0.5
python3 Competitors.py LPRAP $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/LPRAPUKDomain05.txt 1000 0.005 1e-10 2>&1 | tee $OUTPUTDIR_ABS_PATH/LPRAPUKDomain05.log

#sampled edges (%)  0.7
python3 Competitors.py LPRAP $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/LPRAPUKDomain07.txt 1000 0.007 1e-10 2>&1 | tee $OUTPUTDIR_ABS_PATH/LPRAPUKDomain07.log

#sampled edges (%)  1.0
python3 Competitors.py LPRAP $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/LPRAPUKDomain10.txt 1000 0.01 1e-10 2>&1 | tee $OUTPUTDIR_ABS_PATH/LPRAPUKDomain10.log


# Baseline - DSPI

#sampled edges (%)  0.1
python3 Competitors.py  DSPI $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/DSPIUKDomain01.txt 35000 0.999 2>&1 | tee $OUTPUTDIR_ABS_PATH/DSPIUKDomain01.log

#sampled edges (%)  0.3
python3 Competitors.py  DSPI $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/DSPIUKDomain03.txt 10000 0.999 2>&1 | tee $OUTPUTDIR_ABS_PATH/DSPIUKDomain03.log

#sampled edges (%)  0.5
python3 Competitors.py  DSPI $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/DSPIUKDomain05.txt 4000 0.999 2>&1 | tee $OUTPUTDIR_ABS_PATH/DSPIUKDomain05.log

#sampled edges (%)  0.7
python3 Competitors.py  DSPI $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/DSPIUKDomain07.txt 1500 0.999 2>&1 | tee $OUTPUTDIR_ABS_PATH/DSPIUKDomain07.log

#sampled edges (%)  1.0
python3 Competitors.py  DSPI $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/DSPIUKDomain10.txt 1000 0.999 2>&1 | tee $OUTPUTDIR_ABS_PATH/DSPIUKDomain10.log 


# Proposed - CUR_Trans

#sampled edges (%)  0.1
python3 CUR.py CUR_Trans  $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/CUR_TransUKDomain01.txt 0.00002 105153952 0.012 2>&1 | tee $OUTPUTDIR_ABS_PATH/CUR_TransUKDomain01.log

#sampled edges (%)  0.3
python3 CUR.py CUR_Trans  $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/CUR_TransUKDomain03.txt 0.00005 105153952 0.03 2>&1 | tee $OUTPUTDIR_ABS_PATH/CUR_TransUKDomain03.log

#sampled edges (%)  0.5
python3 CUR.py CUR_Trans  $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/CUR_TransUKDomain05.txt 0.0001 105153952 0.055 2>&1 | tee $OUTPUTDIR_ABS_PATH/CUR_TransUKDomain05.log

#sampled edges (%)  0.7
python3 CUR.py CUR_Trans  $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/CUR_TransUKDomain07.txt 0.00015 105153952 0.08 2>&1 | tee $OUTPUTDIR_ABS_PATH/CUR_TransUKDomain07.log

#sampled edges (%)  1.0
python3 CUR.py CUR_Trans  $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/CUR_TransUKDomain10.txt 0.0002 105153952 0.09 2>&1 | tee $OUTPUTDIR_ABS_PATH/CUR_TransUKDomain10.log


# Proposed - T2

#sampled edges (%)  0.1
python3 T2.py $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/T2UKDomain01.txt 0.004 2>&1 | tee $OUTPUTDIR_ABS_PATH/T2UKDomain01.log

#sampled edges (%)  0.3
python3 T2.py $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/T2UKDomain03.txt 0.01 2>&1 | tee $OUTPUTDIR_ABS_PATH/T2UKDomain03.log

#sampled edges (%)  0.5
python3 T2.py $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/T2UKDomain05.txt 0.015 2>&1 | tee $OUTPUTDIR_ABS_PATH/T2UKDomain05.log

#sampled edges (%)  0.7
python3 T2.py $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/T2UKDomain07.txt 0.02  2>&1 | tee $OUTPUTDIR_ABS_PATH/T2UKDomain07.log

#sampled edges (%)  1.0
python3 T2.py $DATADIR_ABS_PATH/UKDomain.txt $OUTPUTDIR_ABS_PATH/T2UKDomain10.txt 0.025 2>&1 | tee $OUTPUTDIR_ABS_PATH/T2UKDomain10.log






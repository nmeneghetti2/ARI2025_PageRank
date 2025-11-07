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

# Baseline - Networkit
python3 Competitors.py  GroundTruth $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/GroundTruthOrkut.txt 2>&1 | tee $OUTPUTDIR_ABS_PATH/GroundTruthOrkut.log

# Baseline - ApproxRank

#sampled edges (%)  0.1
python3 Competitors.py  ApproxRank $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/ApproxRankOrkut01.txt 0.02 3072441 2>&1 | tee $OUTPUTDIR_ABS_PATH/ApproxRankOrkut01.log

#sampled edges (%)  0.3
python3 Competitors.py  ApproxRank $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/ApproxRankOrkut03.txt 0.045 3072441 2>&1 | tee $OUTPUTDIR_ABS_PATH/ApproxRankOrkut03.log

#sampled edges (%)  0.5
python3 Competitors.py  ApproxRank $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/ApproxRankOrkut05.txt 0.06 3072441 2>&1 | tee $OUTPUTDIR_ABS_PATH/ApproxRankOrkut05.log

#sampled edges (%)  0.7
python3 Competitors.py  ApproxRank $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/ApproxRankOrkut07.txt 0.075 3072441 2>&1 | tee $OUTPUTDIR_ABS_PATH/ApproxRankOrkut07.log

#sampled edges (%)  1.0
python3 Competitors.py  ApproxRank $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/ApproxRankOrkut10.txt 0.09 3072441 2>&1 | tee $OUTPUTDIR_ABS_PATH/ApproxRankOrkut10.log

# Baseline - LPRAP

#sampled edges (%)  0.1
python3 Competitors.py LPRAP $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/LPRAPOrkut01.txt 1000 0.001 1e-8 2>&1 | tee $OUTPUTDIR_ABS_PATH/LPRAPOrkut01.log

#sampled edges (%)  0.3
python3 Competitors.py LPRAP $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/LPRAPOrkut03.txt 1000 0.003 1e-8 2>&1 | tee $OUTPUTDIR_ABS_PATH/LPRAPOrkut03.log

#sampled edges (%)  0.5
python3 Competitors.py LPRAP $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/LPRAPOrkut05.txt 1000 0.005 1e-8 2>&1 | tee $OUTPUTDIR_ABS_PATH/LPRAPOrkut05.log

#sampled edges (%)  0.7
python3 Competitors.py LPRAP $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/LPRAPOrkut07.txt 1000 0.007 1e-8 2>&1 | tee $OUTPUTDIR_ABS_PATH/LPRAPOrkut07.log

#sampled edges (%)  1.0
python3 Competitors.py LPRAP $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/LPRAPOrkut10.txt 1000 0.01 1e-8 2>&1 | tee $OUTPUTDIR_ABS_PATH/LPRAPOrkut10.log

# Baseline - DSPI

#sampled edges (%)  0.1
python3 Competitors.py  DSPI $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/DSPIOrkut01.txt 130000 0.999 2>&1 | tee $OUTPUTDIR_ABS_PATH/DSPIOrkut01.log

#sampled edges (%)  0.3
python3 Competitors.py  DSPI $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/DSPIOrkut03.txt 20000 0.999 2>&1 | tee $OUTPUTDIR_ABS_PATH/DSPIOrkut03.log

#sampled edges (%)  0.5
python3 Competitors.py  DSPI $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/DSPIOrkut05.txt 8000 0.999 2>&1 | tee $OUTPUTDIR_ABS_PATH/DSPIOrkut05.log

#sampled edges (%)  0.7
python3 Competitors.py  DSPI $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/DSPIOrkut07.txt 4000 0.999 2>&1 | tee $OUTPUTDIR_ABS_PATH/DSPIOrkut07.log

#sampled edges (%)  1.0
python3 Competitors.py  DSPI $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/DSPIOrkut10.txt 1500 0.999 2>&1 | tee $OUTPUTDIR_ABS_PATH/DSPIOrkut10.log 


# Proposed - CUR_Trans

#sampled edges (%)  0.1
python3 CUR.py CUR_Trans  $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/CUR_TransOrkut01.txt 0.00018 3072441 0.0065 2>&1 | tee $OUTPUTDIR_ABS_PATH/CUR_TransOrkut01.log

#sampled edges (%)  0.3
python3 CUR.py CUR_Trans  $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/CUR_TransOrkut03.txt 0.00048 3072441 0.015 2>&1 | tee $OUTPUTDIR_ABS_PATH/CUR_TransOrkut03.log

#sampled edges (%)  0.5
python3 CUR.py CUR_Trans  $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/CUR_TransOrkut05.txt 0.0009 3072441 0.025 2>&1 | tee $OUTPUTDIR_ABS_PATH/CUR_TransOrkut05.log

#sampled edges (%)  0.7
python3 CUR.py CUR_Trans  $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/CUR_TransOrkut07.txt 0.0014 3072441 0.035 2>&1 | tee $OUTPUTDIR_ABS_PATH/CUR_TransOrkut07.log

#sampled edges (%)  1.0
python3 CUR.py CUR_Trans  $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/CUR_TransOrkut10.txt 0.0022 3072441 0.05 2>&1 | tee $OUTPUTDIR_ABS_PATH/CUR_TransOrkut10.log


# Proposed - T2

#sampled edges (%)  0.1
python3 T2.py $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/T2Orkut01.txt 0.002 2>&1 | tee $OUTPUTDIR_ABS_PATH/T2Orkut01.log

#sampled edges (%)  0.3
python3 T2.py $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/T2Orkut03.txt 0.004 2>&1 | tee $OUTPUTDIR_ABS_PATH/T2Orkut03.log

#sampled edges (%)  0.5
python3 T2.py $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/T2Orkut05.txt 0.007 2>&1 | tee $OUTPUTDIR_ABS_PATH/T2Orkut05.log

#sampled edges (%)  0.7
python3 T2.py $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/T2Orkut07.txt 0.01  2>&1 | tee $OUTPUTDIR_ABS_PATH/T2Orkut07.log

#sampled edges (%)  1.0
python3 T2.py $DATADIR_ABS_PATH/Orkut.txt $OUTPUTDIR_ABS_PATH/T2Orkut10.txt 0.015 2>&1 | tee $OUTPUTDIR_ABS_PATH/T2Orkut10.log





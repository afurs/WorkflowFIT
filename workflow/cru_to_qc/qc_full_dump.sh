#!/usr/bin/env bash

set -u
alienv load O2Suite/latest-fitdaq_tests-o2 -w /data/work/alice/sw
READOUT="readout.exe file:/home/flp/work/online_dataflow/v1/readout_stf_test02.cfg"

STF_BUILDER="StfBuilder"
STF_BUILDER+=" --id stf_builder-0"
STF_BUILDER+=" --session=default"
STF_BUILDER+=" --transport shmem"
STF_BUILDER+=" --dpl-channel-name=dpl-chan"
STF_BUILDER+=" --detector FT0"
STF_BUILDER+=" --detector-rdh 6"
STF_BUILDER+=" --rdh-filter-empty-trigger"

STF_BUILDER+=" --channel-config \"name=readout,type=pull,method=connect,address=ipc://@readout-fmq-stfb,transport=shmem,rateLogging=1\""
STF_BUILDER+=" --channel-config \"name=dpl-chan,type=push,method=bind,address=ipc://@stf-builder-dpl-pipe-0,transport=shmem,rateLogging=1\""

MID_STEP="o2-dpl-raw-proxy -b --session=default --severity=debug --dataspec \"A1:FT0/RAWDATA\""
MID_STEP+=" --channel-config \"name=readout-proxy,type=pull,method=connect,address=ipc://@stf-builder-dpl-pipe-0,transport=shmem,rateLogging=1\""

MID_STEP+=" | o2-dpl-output-proxy -b --session default --severity=debug --dataspec \"A1:FT0/RAWDATA\""
MID_STEP+=" --dpl-output-proxy '--channel-config \"name=downstream,type=push,method=bind,address=ipc://@dpl-pipe-0,rateLogging=1,transport=shmem\"'"

MID_STEP+=" | o2-dpl-run -b --session default --run"

QC_LOCAL="o2-dpl-raw-proxy -b --session=default --severity=debug --dataspec \"A1:FT0/RAWDATA\""
QC_LOCAL+=" --channel-config \"name=readout-proxy,type=pull,method=connect,address=ipc://@stf-builder-dpl-pipe-0,transport=shmem,rateLogging=1\""
QC_LOCAL+=" | o2-ft0-flp-dpl-workflow -b --session=default --severity=debug --disable-root-output --dump-blocks-reader"
QC_LOCAL+=" | o2-qc -b --session default --config json:///home/flp/work/online_dataflow/v1/basic-config_2.json"

QC_REMOTE="o2-qc -b --session default --config json:///home/flp/work/online_dataflow/v1/basic-config_2.json --remote"

xterm -geometry 90x57+1120+0 -hold -e "$READOUT" & 
xterm -geometry 90x57+1120+0 -hold -e "$STF_BUILDER" & 
#xterm -geometry 90x57+1120+0 -hold -e "$MID_STEP" & 
xterm -geometry 90x57+1120+0 -hold -e "$QC_LOCAL" &
#xterm -geometry 90x57+1120+0 -hold -e "$QC_REMOTE"
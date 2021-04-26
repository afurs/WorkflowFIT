#!/usr/bin/env bash

set -u
#alienv load O2Suite/latest-dev_ft0_tests-o2 -w /home/flp/alice/sw
NPIPES=5

READOUT="readout.exe file:readout_stf_test02.cfg"

STF_BUILDER="StfBuilder"
STF_BUILDER+=" --id stf_builder-0"
STF_BUILDER+=" --session=default"
STF_BUILDER+=" --transport shmem"
STF_BUILDER+=" --dpl-channel-name=dpl-chan"
STF_BUILDER+=" --detector FT0"
STF_BUILDER+=" --detector-rdh 6"
STF_BUILDER+=" --rdh-filter-empty-trigger"
#STF_BUILDER+=" --rate 50000"
#STF_BUILDER+=" --stand-alone"
#STF_BUILDER+=" --io-threads 10"

STF_BUILDER+=" --channel-config \"name=readout,type=pull,method=connect,address=ipc://@readout-fmq-stfb,transport=shmem,rateLogging=1\""
STF_BUILDER+=" --channel-config \"name=dpl-chan,type=push,method=bind,address=ipc://@stf-builder-dpl-pipe-0,transport=shmem,rateLogging=1\""

#MID_STEP="o2-dpl-raw-proxy -b --session=default --severity=debug --dataspec \"A1:FT0/RAWDATA\""
#MID_STEP+=" --channel-config \"name=readout-proxy,type=pull,method=connect,address=ipc://@stf-builder-dpl-pipe-0,transport=shmem,rateLogging=1\""

#MID_STEP+=" | o2-dpl-output-proxy -b --session default --severity=debug --dataspec \"A1:FT0/RAWDATA\""
#MID_STEP+=" --dpl-output-proxy '--channel-config \"name=downstream,type=push,method=bind,address=ipc://@dpl-pipe-0,rateLogging=1,transport=shmem\"'"

#MID_STEP+=" | o2-dpl-run -b --session default --run"

QC_LOCAL="o2-dpl-raw-proxy -b --session=default --severity=debug --dataspec \"A1:FT0/RAWDATA\""
QC_LOCAL+=" --channel-config \"name=readout-proxy,type=pull,method=connect,address=ipc://@stf-builder-dpl-pipe-0,transport=shmem,rateLogging=1\""
QC_LOCAL+=" --pipeline readout-proxy:${NPIPES}"

QC_LOCAL+=" | o2-ft0-flp-dpl-workflow -b --session=default --severity=debug --disable-root-output"
QC_LOCAL+=" --pipeline ft0-datareader-dpl:${NPIPES}"
#QC_LOCAL+=" --readers ${NPIPES}"

#QC_LOCAL+=" | o2-qc -b --session default --config json://basic-config_2.json"
#QC_LOCAL+=" | o2-qc -b --session default --config json://basic-config_2.json"
#QC_LOCAL+=" "
QC_LOCAL+=" | o2-dpl-output-proxy -b --session default --severity=debug --dataspec \"digits:FT0/DIGITSBC/0;channels:FT0/DIGITSCH/0\""
QC_LOCAL+=" --dpl-output-proxy '--channel-config \"name=downstream,type=push,method=bind,address=ipc://@dpl-pipe-0,rateLogging=1,transport=shmem\"'"

QC_LOCAL+=" |  o2-dpl-run -b --session default --run --resources-monitoring 1"
#QC_LOCAL+=" --readers dpl-output-proxy:${NPIPES}"
#QC_LOCAL+=" --pipeline dpl-output-proxy:${NPIPES}"

#QC_REMOTE="o2-qc -b --session default --config json://basic-config_2.json --remote"
STF_SENDER="StfSender"
STF_SENDER+=" --id stfs"
STF_SENDER+="  --detector FT0"
STF_SENDER+=" --detector-rdh 6"
STF_SENDER+=" --transport shmem"
STF_SENDER+=" --session default"
STF_SENDER+=" --stand-alone"
STF_SENDER+=" --input-channel-name=input-chan"
STF_SENDER+=" --channel-config name=input-chan,type=pull,method=connect,address=ipc://@dpl-pipe-0,transport=shmem,rateLogging=1"

xterm +j -fa 'Monospace' -fs 14 -geometry 90x57+1120+0 -hold -e "$STF_BUILDER" & 
#xterm -geometry 90x57+1120+0 -hold -e "$MID_STEP" & 
xterm  -sl 10000 -fa 'Monospace' -fs 14 -geometry 90x57+1120+0 -hold -e "$QC_LOCAL" &
xterm  -sl 10000 -fa 'Monospace' -fs 14 -geometry 90x57+1120+0 -hold -e "$STF_SENDER" &
sleep 20s
xterm  -sl 10000 -fa 'Monospace' -fs 14 -geometry 90x57+1120+0 -hold -e "$READOUT"

#xterm -geometry 90x57+1120+0 -hold -e "$QC_REMOTE"
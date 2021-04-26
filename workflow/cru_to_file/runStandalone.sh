#!/usr/bin/env bash

set -u
READOUT="o2-readout-exe file:readout_stf.cfg"

STF_BUILDER="StfBuilder"
STF_BUILDER+=" --id stf_builder-0"
STF_BUILDER+=" --session=default"
STF_BUILDER+=" --transport shmem"
STF_BUILDER+=" --dpl-channel-name=dpl-chan"
STF_BUILDER+=" --detector FT0"
STF_BUILDER+=" --detector-rdh 6"
#STF_BUILDER+=" --rdh-filter-empty-trigger"
STF_BUILDER+=" --stand-alone"

STF_BUILDER+=" --channel-config \"name=readout,type=pull,method=connect,address=ipc://@readout-fmq-stfb,transport=shmem,rateLogging=1\""
STF_BUILDER+=" --channel-config \"name=dpl-chan,type=push,method=bind,address=ipc://@stf-builder-dpl-pipe-0,transport=shmem,rateLogging=1\""

xterm -sl 10000 -fa 'Monospace' -fs 14 -geometry 90x57+1120+0 -hold -e "$READOUT" & 
xterm -sl 10000 -fa 'Monospace' -fs 14 -geometry 90x57+1120+0 -hold -e "$STF_BUILDER"

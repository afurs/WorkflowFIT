# File to QC/Full(no QC) dataflow
## Howto start:
1. cd-ing to this sub-directory
2. Start:
  1. QC workflow:
````
source qc_workflow_full.sh
````
  1. Full workflow chain(readout->...->StfSender:
````
source workflow_full.sh
````

## Configuration
1. QC json configuration file qc_digits:
  1. For changing QC cycle duration, edit "cycleDurationSeconds" field.
  2. Prepare list of ChannelIDs in "ChannelIDs" field for 1D histograms to be initialized with a given IDs. Symbol "," should be used as delimeter. Remove "ChannelIDs" field from config file if you need to initialize 1D hists for all channels.
2. Readout config file readout_stf_file.cfg, segment "consumer-rec":
  1. For dropping emptyHBFs: dropEmptyHBFrames=1

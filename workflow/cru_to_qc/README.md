# CRU to QC dataflow
## Howto start:
1. cd-ing to this sub-directory
2. Several options
  1. Without data storing(ony QC):
````
source qc_full.sh
````
  2. Store only digits(WARNING! For safe root file(digits) saving, use Ctrl-C on xterm window containing O2 workflows!):
````
source qc_full2file_digits.sh
````
  3. Store only raw data: 
````
source qc_full2file_raw.sh 
````
  4. Store both type of data(WARNING! For safe root file(digits) saving, use Ctrl-C on xterm window containing O2 workflows!):
````
source qc_full2file.sh
````

## Configuration
1. QC json configuration file qc_digits:
  1. For changing QC cycle duration, edit "cycleDurationSeconds" field.
  2. Prepare list of ChannelIDs in "ChannelIDs" field for 1D histograms to be initialized with a given IDs. Symbol "," should be used as delimeter. Remove "ChannelIDs" field from config file if you need to initialize 1D hists for all channels.
2. Readout config file readout_stf_file.cfg, segment "consumer-rec":
  1. For dropping emptyHBFs: dropEmptyHBFrames=1

## Cleaning ALL QC objects(MO/QO)
````
aliswmod enter QualityControl
repoCleaner.py --config config_cleaner_all.yaml
````

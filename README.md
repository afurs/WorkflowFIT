# Guideline for FIT data workflow

## Packages
* ReadoutCard: https://github.com/AliceO2Group/ReadoutCard
* Readout https://github.com/AliceO2Group/Readout
* DataDistribution https://github.com/AliceO2Group/DataDistribution
* AliceO2 https://github.com/AliceO2Group/AliceO2
* QualityControl https://github.com/AliceO2Group/QualityControl

All this packges could be installed from repository by using FLPSuite(as frontend) and O2Suite (as backend and if you need to develop your code): 
* O2Suite: https://github.com/AliceO2Group/QualityControl/blob/master/doc/QuickStart.md#setup
* FLPSuite: https://alice-o2-project.web.cern.ch/flp-suite

## Preparation
1. Load enviroment, there are too cases (second one is better for tests):
  1. For FLPSuite: 
````
  aliswmod enter Readout DataDistribution O2
````
  2. For O2Suite(some options depends on installation conditions):
````
alienv enter O2Suite/latest-dev_fit-o2 -w /home/flp/alice/sw
````
2. Check CRU configurations:
  1. Card lists:
````
o2-roc-lists
````
  2. Check status for each logic CRU device:
````
o2-roc-status --id=#0
````
  3. Configure links you need(example for cruID=#0 and links 9,11):
````
o2-roc-config --id=#0 --clock=TTC --pon-upstream --dyn-offset --onu-address=1 --gbtmux=TTC --datapathmode=PACKET --gbtmode=GBT --links=9,11 --force
````
  4. Check again by using o2-roc-status
3. Check FEE configuration on its side(ControlServer, DCS, etc). It should be done after each o2-roc-config command executed!
4. Check LTU configuration:
  1. Use "ltu" login on FLP machine(for test setup)
  2. Start "qtltu"
  3. Set to "Continious mode"
  4. (Optionally) Use PrePulse
5. Start workflow you need(description in sub-directories):
  1. Choose dataflow type(subdirectory in this repository).
  2. Start script.
  3. Start LTU
  4. Stop LTU
  5. Stop workflow by pressing ctrl+c in opened xterm windows, and then close them. It's important if you need to write digits into ROOT file during workflow.
6. Investigate data you collected(into file or QC objects)

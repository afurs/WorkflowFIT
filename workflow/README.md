# FIT workflow description for experimental setup
## Workflows
* cru_to_file: Readout(equipment-cru -> consumer-rec + consumer-fmq)->StfBuilder(standalone, just for RDH checking)
* cru_to_qc: Readout(equipment-cru -> consumer-fmq)->StfBuilder->O2->QC
* file_to_qc Readout(equipment-player -> consumer-fmq)->StfBuilder->O2->QC



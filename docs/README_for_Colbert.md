# User Guide

## Inputs

The structure of the data folder should be organized as below:

    Data
    │
    ├── w1
    │   ├── *.yaml
    │   └── *_HUDS.avi
    │
    ├── w2
    │   ├── *.yaml
    │   └── *_HUDS.avi
    │
    ├── w3
    │   ├── *.yaml
    │   └── *_HUDS.avi
    ...

## Outputs

* `machine_label.csv` gives frames of the forward, reversal, turn and roaming.
* `machine_label_v2.csv` gives frames of the forward and reorientation, where the reorientation contains the reversal, turn and roaming.

## Workflow 

<img src = "markdown_figs/workflow.png" width=90% align="center">

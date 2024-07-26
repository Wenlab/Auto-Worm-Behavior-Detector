[![Youtube](https://img.shields.io/badge/YouTube-Demo-red)](https://www.youtube.com/watch?v=Y0aR_9A48vo)

[![GitHub](https://img.shields.io/github/license/Wenlab/Machine_Label_of_Colbert)](https://github.com/Wenlab/Machine_Label_of_Colbert/blob/master/LICENSE)

# Update Log

* `2023-05-24`: `version 1.0.0`, first release.
* `2023-09-16`: `version 1.1.0`, add the use of $a_3$ when labelling turn.
* `2023-09-18`: `version 1.2.0`, add roaming.
* `2024-05-14`: `version 1.3.0`, use $\frac{boundary_A + boundary_B}{2}$ to correct the online centerline recorded by [the CoLBeRT system](https://github.com/samuellab/mindcontrol).
* `2024-07-19`: `version 1.4.0`, now this software can be used to process centerlines recorded by any platforms!

# Demo

![Demo GIF](/markdown_figs/demo.gif)

This experiment is recorded by [the CoLBeRT system](https://github.com/samuellab/mindcontrol).

See [the full video](https://www.youtube.com/watch?v=Y0aR_9A48vo) of this experiment on YouTube!

# User Guide

## Inputs

The structure of the data folder should be organized as below:

    Data
    │
    ├── w1
    │   ├── useful_data
    │   │	├── centerlines_camera.mat
    │   │	├── centerlines_lab.mat
    │	│   ├── timestamps.mat
    │   │   ├── idx_beyond_edge.mat
    │	
    ├── w2
    │   ├── useful_data
    │   │	├── centerlines_camera.mat
    │   │	├── centerlines_lab.mat
    │	│   ├── timestamps.mat
    │   │   ├── idx_beyond_edge.mat
    │
    ├── w3
    │   ├── useful_data
    │   │	├── centerlines_camera.mat
    │   │	├── centerlines_lab.mat
    │	│   ├── timestamps.mat
    │   │   ├── idx_beyond_edge.mat
    │
    ...

Here, `centerlines_camera.mat` and `centerlines_lab.mat` are essential, while `timestamps.mat` and `idx_beyond_edge.mat` are optional.



## Outputs

* `machine_label.csv` gives frames of the forward, reversal, turn and roaming.
* `machine_label_v2.csv` gives frames of the forward and reorientation, where the reorientation contains the reversal, turn and roaming.



## Workflow

![Workflow_en](markdown_figs/Workflow_en.png)

## Other Guides

* For finely tuning super parameters, check here.
* For guidance of [the CoLBeRT system](https://github.com/samuellab/mindcontrol), check here.
* For log of fixing bugs, check here.

# Performance

I found 5 human experts and asked them to label a video of about 20000 frames. Then, I only used the frames which they totally agree to be certain behavior. You can check the video, human labels, and related codes [here](https://github.com/Wenlab/Auto-Worm-Behavior-Detector/tree/master/performance).

```
Proportion of frames lacking unanimous consensus among human experts: 15.84%
```

## Under Three Categories

```
Accuracy: 91.36%
Error: 8.64%
---------------
Precision of Turn: 100.00%
Recall of Turn: 44.60%
Precision of Forward: 95.82%
Recall of Forward: 95.68%
Precision of Reversal: 71.33%
Recall of Reversal: 99.70%
```

##  Under Two Categories

```
Accuracy: 93.47%
Error: 6.53%
---------------
Precision of Forward: 95.82%
Recall of Forward: 95.68%
Precision of Reorientation: 85.70%
Recall of Reorientation: 86.11%
```



# Contact

- [Yixuan Li](https://github.com/Physics-Lee) (`yixuanli@mail.ustc.edu.cn`)

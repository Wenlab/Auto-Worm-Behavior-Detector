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

* `centerlines_camera.mat`: centerlines in the camera coordinates. (optional)
* `centerlines_lab.mat`: centerlines in the lab coordinates. (essential)
* `timestamps.mat`: time stamps for frames. (optional)
* `idx_beyond_edge.mat`: index of tail-beyond-edge-situation. (optional)



### Data Structure of Inputs

Denote `N_frame` as the number of frames. **You need to take 100 points uniformly on the centerline of a worm.** You also need to convert the unit of the lab coordinates to millimeter.

* `centerlines_camera.mat`: `N_frame*1` cell array
  * Each element is `2*100` numerical array, where 1st row stands for x coordinates and 2nd row stands for y coordinates.
  * unit: pixel.
* `centerlines_lab.mat`: `N_frame*1` cell array
  * Each element is `2*100` numerical array, where 1st row stands for x coordinates and 2nd row stands for y coordinates.
  * **unit: mm.**
* `timestamps.mat`: `N_frame*1` numerical array
  * Each element is the correspoinding time stamp of that frame.
* `idx_beyond_edge.mat`: `N_frame*1` Boolean array
  * Each element is the correspoinding true-or-false indicator of that frame.



### Folder Structure of Inputs

The structure of the data folder should be organized as below:

    Data
    ├─── w1
    │    ├─── useful_data
    |    |        centerlines_camera.mat
    |    |        centerlines_lab.mat
    |    |        timestamps.mat
    |    |        idx_beyond_edge.mat
    │	
    ├── w2
    │    ├─── useful_data
    |    |        centerlines_camera.mat
    |    |        centerlines_lab.mat
    |    |        timestamps.mat
    |    |        idx_beyond_edge.mat
    │
    ├─── w3
    │    ├─── useful_data
    |    |        centerlines_camera.mat
    |    |        centerlines_lab.mat
    |    |        timestamps.mat
    |    |        idx_beyond_edge.mat
    │
    ...



## Outputs

* `machine_label.csv` gives frames of the forward, reversal, turn and roaming.
* `machine_label_v2.csv` gives frames of the forward and reorientation, where the reorientation contains the reversal, turn and roaming.



## Workflow

![Workflow_en](markdown_figs/Workflow_en.png)

# Performance

I found 5 human experts and asked them to label a video of about 20000 frames. Then, I only used the frames which they totally agree to be certain behavior. You can check the video, human labels, and related codes [here](https://github.com/Wenlab/Auto-Worm-Behavior-Detector/tree/master/performance).

```
Proportion of frames lacking unanimous consensus among human experts: 15.84%
```

## Performance Under Three Categories

```
Accuracy: 91.36%
Error: 8.64%
---------------
Precision of Forward: 95.82%
Recall of Forward: 95.68%
Precision of Reversal: 71.33%
Recall of Reversal: 99.70%
Precision of Turn: 100.00%
Recall of Turn: 44.60%
```

##  Performance Under Two Categories

```
Accuracy: 93.47%
Error: 6.53%
---------------
Precision of Forward: 95.82%
Recall of Forward: 95.68%
Precision of Reorientation: 85.70%
Recall of Reorientation: 86.11%
```



# Other Guides

* For finely tuning super parameters, check [here](https://github.com/Wenlab/Auto-Worm-Behavior-Detector/tree/master/docs/Super_Parameters.md).
* For guidance of [the CoLBeRT system](https://github.com/samuellab/mindcontrol), check [here](https://github.com/Wenlab/Auto-Worm-Behavior-Detector/tree/master/docs/README_for_Colbert.md).
* For log of fixing bugs, check [here](https://github.com/Wenlab/Auto-Worm-Behavior-Detector/tree/master/docs/log_of_fixing_bug).



# Contact

* [Yixuan Li](https://github.com/Physics-Lee) (`yixuanli@mail.ustc.edu.cn`)

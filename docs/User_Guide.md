# User Guide

## Inputs

* `centerlines_camera.mat`: centerlines in the camera coordinates. (optional)
* `centerlines_lab.mat`: centerlines in the lab coordinates. **(essential)**
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
  * **unit: s.**
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

* `machine_label.csv` gives frames of forward, reversal, turn, and roaming.
* `machine_label_v2.csv` gives frames of forward and reorientation, where the reorientation contains reversal, turn, and roaming.



## Workflow

![Workflow_en](../markdown_figs/Workflow_en.png)

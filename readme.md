[![Youtube](https://img.shields.io/badge/YouTube-Demo-red)](https://www.youtube.com/watch?v=Y0aR_9A48vo)

[![GitHub](https://img.shields.io/github/license/Wenlab/Machine_Label_of_Colbert)](https://github.com/Wenlab/Machine_Label_of_Colbert/blob/master/LICENSE)

# Update Log

* 2023-05-24: version 1.0.0, first release.
* 2023-07-16: Now you can add labels to the video!
* 2023-09-16: version 1.1.0, add the use of $a_3$ when labelling turn.
* 2023-09-18: version 1.2.0, add roaming.

# Demo

![Demo GIF](/markdown_figs/demo.gif)

This GIF is from N2-Ctl20230317-W1, an experiment done by Runhui Li, my partner.

See [the full video](https://www.youtube.com/watch?v=Y0aR_9A48vo) of this experiment on YouTube!

# User Guide

## General Guide

* Purpose: this repository is an algorithm to label the behaviours of C.elegans under [the CoLBeRT system](https://github.com/samuellab/mindcontrol).

* Input and output
  * The input of the algorithm is a `.yaml` file, which is obtained when photographing the worms.
  * The main output of the algorithm is a `.csv` file, which contains the machine label. See below for all outputs.

* Open `interactive.mlapp` to use the GUI.

<img src = "/markdown_figs/GUI.png" width=50% align="center">

* workflow

<img src = "/markdown_figs/workflow.png" width=90% align="center">

* all outputs
  * `machine_label.csv` gives frames of the forward, reversal, turn and roaming.

  * `machine_label_v2.csv` gives frames of the forward and reorientation, where the reorientation contains the reversal, turn and roaming.

  * `beyond_the_edge.csv` gives the frames when the tail of the C.elegans is beyond the edge of the camera.
  * `head_tail_human_flip.csv` gives the frames when the human flips the head and the tail of the C.elegans.
  * `figure1.png` shows Tukey test for the length of the centerline.
  * `figure2.png` shows Tukey test for the Euclidean distance between the head and the tail.
  * `figure3.png` shows Tukey test for $a_3$.
  * `figure4.png` shows Tukey test for the phase speed in the phase space of $a_1$ and $a_2$.
  * `figure5.png` shows Tukey test for the path length of the worm in the absolute coordinate system.




## The Structure of the Data Folder

The structure of the data folder should be organized as below:

    Data
    │
    ├── w1
    │   ├── *.avi
    │   ├── *.yaml
    │   └── *_HUDS.avi
    │
    ├── w2
    │   ├── *.avi
    │   ├── *.yaml
    │   └── *_HUDS.avi
    │
    ├── w3
    │   ├── *.avi
    │   ├── *.yaml
    │   └── *_HUDS.avi
    ...



## Super Parameters

### need to change

The only super parameter that you need to change is `frame window`.

The meaning of `frame window`: if the frame window is $x$, then the temporal resolution is $x$ frames.

In simple term: smaller, more accurate.

It is recommended that

* 30 for `machine_label.csv`
* 10 for `machine_label_v2.csv`.



### no need to change

* 1 unit of the stage position == ? um
  * always 0.05
* 1 pixel of the video == ? um
  * 4.2087 for 4x
  * 1.6830 for 10x
* ? frame == 1 s
  * 60-66



## Tips for Human Double Check

It is recommended to have a human-double-check, and here are some tips:

* A turn less than 1 second is likely to be incorrect.
* Machine labels of a certain period of time before the frames of flipping head and tail are likely to be incorrect. 



# Performance

Of course, this project can be seen as a machine learning problem. The label is the behavior and the sample is the frame. I use a unsupervised method to get labels.

Then, when I want to evaluate my algorithm, I meet a hard problem: human experts will have different opinions on certain frames. To figure this out, I use the total-agreement-method. That is, I found 5 human experts and asked them to label a video of 20000 frames. Then, I only used the frame which they totally agree to be certain behavior.

## In 3 categories

```
In 3 categories:
---------------
Accuracy: 93.06%
Error: 6.94%
---------------
Precision of Turn: 100.00%
Recall of Turn: 42.07%
Precision of Forward: 94.78%
Recall of Forward: 98.51%
Precision of Reversal: 82.98%
Recall of Reversal: 99.67%
```

##  In 2 categories

```
In 2 categories:
---------------
Accuracy: 94.71%
Error: 5.29%
---------------
Precision of Forward: 94.78%
Recall of Forward: 98.51%
Precision of Reorientation: 94.47%
Recall of Reorientation: 82.37%
```



# Principle

* process nan: mark `nan` as outliers
* detect head tail human flip.
* detect beyond the edge.
* label turn
  * round 1: use Tukey test of the length of the centerline.
    * double check for Tukey test: I need frames below median*0.75 > 132 (2s). This is used to handle videos without the head-tail-touch turn.
  * round 2: use Tukey test of the Euclidean distance between the head and tail.
  * round 3: use Tukey test of $a_3$
* label Forward and Reversal, using phase trajectory.
  * smooth: if the motion state of a window' pre and post are the same, then let it be that motion state.

* smooth
  * <= frame_window, same as last.
  * for the unlabelled < t_threshold (5 s), if 2 neighbours are the same, let it be the same as its neighbor
  * for the unlabelled < t_threshold (5 s), if a neighbor is 1 or 3, let it be the same as it. PS: 1's priority is higher than 3's.
* label roaming
  * use a absolute value, now is 0.05 mm/s



# Why Does This Algorithm Succeed?

Shortly speaking, the success of this algorithm lies on 2 things

* Tukey test is a **simple, universal** method for detecting **outliers**. It combines both relative value and absolute value.
* Eigen worm is a **simple, universal** method for detecting **the behavior state** of C.elegans.

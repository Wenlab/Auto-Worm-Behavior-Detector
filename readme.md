# User Guide

This repository is an algorithm to label the behaviours of C.elegans under [the CoLBeRT system](https://github.com/samuellab/mindcontrol).

## flow diagram

<img src = "/markdown figs/flow diagram.png" width=100% align="center" style="zoom: 33%;" >

## input

The input of the algorithm is .yaml file.

## output

The output of the algorithm are 5 files:

* machine_label.csv gives frames of the forward, reversal and turn.

* beyond_the_edge.csv gives the frames when the tail of the C.elegans is beyond the edge of the camera.
* head_tail_human_flip.csv gives the frames when the human flips the head and the tail of the C.elegans.
* figure1.png gives Tukey test for the length of the centerline.
* figure2.png gives Tukey test for the Euclidean distance between the head and the tail.



## The parameters

* frame window: if the frame window is $x$, then the temporal resolution is $x$ frames.



## tips

* **A turn less than 1 second is likely to be tail beyond edge situation**. Please check carefully.
* **Machine labels of a certain period of time before the frames of flipping head and tail are likely to be incorrect**. Please check carefully.



# Dive Deeper

## Basic principle of the algorithm

Shortly speaking, the success of this algorithm lies on 2 things

* Tukey test is a concise, universal method for detecting outliers. It combines both percentile (a relative measure) and distance (an absolute measure)
* Eigen worm is a concise, universal and elegant method for detecting the motion state of C.elegans. If the C.elegans has a transverse wave transmitting from head to tail, the phase trajectory in the a_2 a_1 phase space will be counter-clockwise while from tail to head, clockwise.



## Shortcoming

* 我本想用mcd->centerline->saved files，但是遇到了一个问题
  * 我若想解决Colbert中线虫尾巴超出视频的情况，必须把mcd传进去，而不是只传centerline
  * 目前我们实验室只需要用识别Colbert视频，因此我暂时搁置这件事
  * 未来，如果有其它视频需要处理，我可以再写一个GUI，也可以利用nargin。



## Details of the algorithm

* process nan: mark nan as outlier
* detect head tail human flip.
* detect beyond the edge.
* label turn, using Tukey test of the length of the centerline.
  * double check for Tukey test: I need frames below median*0.75 > 132
* label turn, using Tukey test of the Euclidean distance between the head and tail.
  * double check for Tukey test: I need max continuous frames > 33 
* label Forward and Reversal, using phase trajectory.
  * smooth
    * <= frame_window, same as last.
    * for the unlabelled < t_threshold, if 2 neighbours are the same, let it be the same as its neighbor
    * for the unlabelled < t_threshold, if a neighbor is 1 or 3, let it be the same as it. PS: 1's priority is higher than 3's
* process neighbor of turns
  * last neighbor should not be short forward
  * next neighbor should not be short reversal



## Performance of the algorithm

* accuracy: depending on definition of forward, reversal and turn. 
  * This algorithm can detect very short (see temporal resolution) forward and reversal, which may not be what the human want to distinguish.

* precision and recall: depending on definition of forward, reversal and turn. 
  * this algorithm has high recall.

* temporal resolution
  * Theoretically, 1 frame for turn and $frame\_window$ frames for forward and reversal.



## Details of the beyond edge situation

If the beyond edge situation is rare, the histogram will look like:

<img src = "/markdown figs/figure1_NC_w1.png" width=100% align="center">

If the beyond edge situation is common, the histogram will look like:

<img src = "/markdown figs/figure1_WG_w1.png" width=100% align="center">
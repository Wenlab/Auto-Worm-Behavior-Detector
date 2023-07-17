# User Guide

This repository is an algorithm to label the behaviours of C.elegans under [the CoLBeRT system](https://github.com/samuellab/mindcontrol).

The input of the algorithm is mcd.m, which can be obtained from .yaml file.

The output of the algorithm are 5 files:

* machine_label.csv gives frames of the forward, reversal and turn.

* beyond_the_edge.csv gives the frames when the tail of the C.elegans is beyond the edge of the camera.
* head_tail_human_flip.csv gives the frames when the human flips the head and the tail of the C.elegans.
* figure1.png gives Tukey test for the length of the centerline.
* figure2.png gives Tukey test for the Euclidean distance between the head and the tail.

flow diagram:

<img src = "/markdown figs/flow diagram.png" width=100% align="center">

The parameters

* frame window: if the frame window is $x$, then the temporal resolution is $x$ frames.
  * I recommend 30 frame window for machine_label.csv and 10 frame window for machine_label_v2.csv




# tips

* **A turn less than 1 second is likely to be tail beyond edge situation**. Please check carefully.
* **Machine labels of a certain period of time before the frames of flipping head and tail are likely to be incorrect**. Please check carefully.
* If the C.elegans used in the experiment are larger than typical young adult, occurrences of tail beyond edge situation will be more frequent. Therefore, it is advisable to select worms smaller than or equal to typical young adult to perform the experiment to mitigate this phenomenon~
* The algorithm demonstrates remarkable sensitivity, boasting a temporal resolution of 10 frames. This level of sensitivity enables the detection of forward and reverse movements as brief as 1/6s, which may not be shorter than the desired level of the distinction. You can integrate short periods of the machine label manually~

# Basic principle of the algorithm

* Turn
  - When there is body contact, the recognition of centerline will fail (excluding the case where the worm reaches the edge, the fail of the centerline recognition is equivalent to body contact and is a subset of a turn).
    - I **observed** that the length of the centerline becomes shorter in this case.
    - Tukey test.
  - After excluding the previous case, the identification of the centerline is **nearly always** correct.
    - I **observed** that the Euclidean distance between the head and tail is shorter during a turn.
    - Tukey test.
* Forward and Reversal
  - Heng **observed** the phase trajectory in the a_2 a_1 phase space and found that during forward movement, the trajectory rotates counter-clockwise, while during reversal, the trajectory rotates clockwise.
  - Use 10 as frames window.



Shortly speaking, the success of this algorithm lies on 2 things

* Tukey test is a concise, universal method for detecting outliers. It combines both percentile (a relative measure) and distance (an absolute measure)
* Eigen worm is a concise, universal and elegant method for detecting the motion state of C.elegans. If the C.elegans has a transverse wave transmitting from head to tail, the phase trajectory in the a_2 a_1 phase space will be counter-clockwise while from tail to head, clockwise.



# Details of the algorithm

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



# Performance of the algorithm

* accuracy: depending on definition of forward, reversal and turn. This algorithm can detect very short (see temporal resolution) forward and reversal, which may not be what the human want to distinguish.
* precision and recall: recall is more important than precision in this task and this algorithm has high recall.
* temporal resolution
  * Theoretically, 1 frame for turn and 10 frames for forward and reversal.



# Details of the beyond edge situation

If the beyond edge situation is rare, the histogram will look like:

<img src = "/markdown figs/figure1_NC_w1.png" width=100% align="center">

If the beyond edge situation is common, the histogram will look like:

<img src = "/markdown figs/figure1_WG_w1.png" width=100% align="center">
# Why This Algorithm Succeeds?

Shortly speaking, the success of this algorithm lies on 2 things

* Tukey test is a **simple, universal** method for detecting **outliers**. It combines both relative value and absolute value.
* Eigen worm is a **simple, universal** method for detecting the motion state (at least **forward** and **reversal**) of C.elegans.



# Given the reason, how to successfully label shallow turn and roaming?

* try a_3
  * result of a_3 for labelling turn

    * 查全率较高
    * 查准率较低
* don't use a_1, a_2, use velocity in absolute reference frame.



# Performance of the algorithm

* accuracy: high.
  * Quantitatively speaking, depending on definition of forward, reversal and turn.
* temporal resolution: 1 frame for turn and 10 frames for forward and reversal.

## Precision or Recall?

In general, recall is more important than precision. Because human double check can correct wrong recall more easilier than precision.



# Details

* process nan: mark nan as outlier
* detect head tail human flip.
* detect beyond the edge.
* label turn, using Tukey test of the length of the centerline.
  * double check for Tukey test: I need frames below median*0.75 > 132 (2s)
* label turn, using Tukey test of the Euclidean distance between the head and tail.
  * double check for Tukey test: I need max continuous frames > 33 (0.5s)
* label Forward and Reversal, using phase trajectory.
* smooth
  * <= frame_window, same as last.
  * for the unlabelled < t_threshold, if 2 neighbours are the same, let it be the same as its neighbor
  * for the unlabelled < t_threshold, if a neighbor is 1 or 3, let it be the same as it. PS: 1's priority is higher than 3's


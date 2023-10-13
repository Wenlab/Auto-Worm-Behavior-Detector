# Update Log

* 2023-05-24: first release
* 2023-07-16: now you can add labels to the video!
* 2023-09-16: version 1.1.0, add the use of $a_3$ when labelling turn.
* 2023-09-18: version 1.2.0, add roaming.

# Demo

![Demo GIF](/markdown_figs/demo.gif)

This GIF is from N2-Ctl20230317-W1, an experiment done by Runhui Li, my partner.

See [full video](https://www.youtube.com/watch?v=Y0aR_9A48vo) of this experiment on YouTube!

# User Guide

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




# The Structure of the Data Folder

The structure of the data folder should be organized as below:

    Your data folder
    ├───w1
    		*.avi
    		*.yaml
    		*_HUDS.avi
    ├───w2
    		*.avi
    		*.yaml
    		*_HUDS.avi
    ├───w3
    ...



# Super Parameters

## need to change

The only super parameter that you need to change is `frame window`.

The meaning of `frame window`: if the frame window is $x$, then the temporal resolution is $x$ frames.

In simple term: smaller, more accurate.

It is recommended that

* 30 for `machine_label.csv`
* 10 for `machine_label_v2.csv`.



## no need to change

* 1 unit of the stage postion == ? um
  * always 0.05
* 1 pixel of the video == ? um
  * 4.2087 for 4x
  * 1.6830 for 10x
* ? frame == 1 s
  * 60-66



# Tips for Human Double Check

It is recommended to have a human-double-check, and here are some tips:

* A turn less than 1 second is likely to be incorrect.
* Machine labels of a certain period of time before the frames of flipping head and tail are likely to be incorrect. 



# $\Omega$ turn vs shallow turn

This algorithm will label **all** $\Omega$ turn and **some** shallow turn as turn.
# User Guide

* Purpose: this repository is an algorithm to label the behaviours of C.elegans under [the CoLBeRT system](https://github.com/samuellab/mindcontrol).

* Input and output
  * The input of the algorithm is a `.yaml` file, which is obtained when photographing the worms.
  * The output of the algorithm is a `.csv` file, which contains the machine label.

* Open `interactive.mlapp` to use the GUI.

<img src = "/markdown figs/GUI.png" width=50% align="center">

* workflow

<img src = "/markdown figs/workflow.png" width=90% align="center">

* all outputs
  * `machine_label.csv` gives frames of the forward, reversal and turn.

  * `machine_label_v2.csv` gives frames of the forward and reorientation.

  * `beyond_the_edge.csv` gives the frames when the tail of the C.elegans is beyond the edge of the camera.
  * `head_tail_human_flip.csv` gives the frames when the human flips the head and the tail of the C.elegans.
  * `figure1.png` shows Tukey test for the length of the centerline.
  * `figure2.png` shows Tukey test for the Euclidean distance between the head and the tail.




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

The only super parameter that you need to change is `frame window`.

The meaning of `frame window`: if the frame window is $x$, then the temporal resolution is $x$ frames.

It is recommended that 30 for `machine_label.csv` and 10 for `machine_label_v2.csv`.
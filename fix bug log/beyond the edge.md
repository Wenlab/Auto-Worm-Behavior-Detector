# Bug

If the beyond edge situation is rare, the histogram will look like:

<img src = "../markdown figs/rare_beyond_edge.png" width=100% align="center">

<center>(figure: N2-NC20230312-W1)</center>

If the beyond edge situation is common, the histogram will look like:

<img src = "../markdown figs/common_beyond_edge.png" width=100% align="center">

<center>(figure: WEN0216-WG20230504-W1)</center>

# Fix

I have fixed this bug by

* using the protection for beyond-edge-situation when labelling turn.
* using double check in round 2.
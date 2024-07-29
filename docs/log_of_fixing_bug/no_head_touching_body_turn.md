# Bug

If there is no head-touching-body-turn in a video, the histogram will look like below, where Tukey test will give wrong results.

<img src = "../../markdown_figs/no_omega_turn_in_a_video.png" width=80% align="center">

<center>(figure: WEN0216-Or20230524-w3)</center>

# Fix

To fix this, I introduce a double check in round 1.
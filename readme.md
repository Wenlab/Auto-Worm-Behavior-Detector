master branch: design for normal use in WenLab. For example, Liu Qi, Pinjie and Wang Yuan's researches.

integrate_turn_and_reversal_into_reorientation branch: design for taxis project. Updates:

* integrate turn and reversal into reorientation
* eliminate run shorter than 5s
* eliminate reversal shorter than 1s

---

basic principle for machine label:

* Turn
  - When there is body contact, the recognition of centerline will fail (excluding the case where the worm reaches the edge, the fail of the centerline recognition is equivalent to body contact and is a subset of a turn).
    - I **observed** that the length of the centerline becomes **shorter** in this case.
    - Tukey test.
  - After excluding the previous case, the identification of the centerline is **always** correct.
    - I **observed** that the Euclidean distance between the head and tail is **shorter** during a turn.
    - Tukey test.
* Forward and Reversal
  - Heng **observed** the phase trajectory in the a_2 a_1 phase space and found that during forward movement, the trajectory rotates clockwise, while during reversal, the trajectory rotates counter-clockwise.
  - Use 10 as frames window.

---

details

* process nan: mark nan as outlier
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

---

Performance measure of the algorithm

* accuracy: depending on definition of forward, reversal and turn.
* precision （查准率） and recall （查全率）: recall is more important than precision in this task and this algorithm has high recall.
* temporal resolution
  * Theoretically, 1 frame for turn and 10 frames for forward and reversal.

---

tomorrow

* beyond edge
* 杂质

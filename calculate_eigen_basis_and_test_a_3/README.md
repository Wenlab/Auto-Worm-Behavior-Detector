# When calculating the eigen basis

delete Outlier: centerline is wrong in below circumstances

* nan
* beyond the edge
* touch foreign matter
* when the head touch the body **(This is the reason why we can't get the correct a_3)**

use `isnan` can figure out situation 1 and use Tukey test for the distance between the head and the tail can figure out situation 2, 3, 4.

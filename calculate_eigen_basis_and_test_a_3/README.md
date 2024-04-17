# When calculating the eigen basis

delete Outlier: centerline is wrong in below circumstances

* nan: use `isnan`
* beyond the edge: easy
* when the head touch the body: use Tukey test for the length of the centerline

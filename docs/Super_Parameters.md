# Need to be Tuned

There are two super parameters that you need to tuned. However, the default values have already given results which are good enough.

## For Forward and Reversal

The first is `frame window`. The meaning of  it: if `frame window` is $x$, then the temporal resolution of forward and reversal is $x$ frames. In simple term: smaller, more accurate.

By a rule of thumb, it is recommended that

* `frame window` = 30 for `machine_label.csv`
* `frame window` = 10 for `machine_label_v2.csv`.

## For Roaming

The second is `speed threshold for roaming`. The meaning of  it: if `speed threshold for roaming` is $x$, then frames which has speed (of central part of the worm) lower than it will be labelled as roaming. You can change it according to different force of friction in your worms' environment.

By a rule of thumb, it is recommended that

* `speed threshold for roaming` = 0.05 mm/s for crawling worms.



# Do Not Need to be Tuned

Below super parameters do not need to be tuned. I simply want to list them out.

## For Turn

* `IQR_index` when applying Tukey Method.



## For Forward and Reversal

* `std2mean` when labelling forward and reversal.

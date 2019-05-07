## Evaluate_using_Kappa
codes for evaluating clustering methods using kappa

## How to use:
Suppose that there are 10 samples with the true labels [1,1,1,1,1,1,2,2,3,3], our codes can be used to evaluate the goodness of the labels obtained by clustering method. For example, if the calculated labels are [2,2,2,2,2,2,3,3,3,1], our codes can be used as follows:   

### cal_kappa(c(1,1,1,1,1,1,2,2,3,3), c(2,2,2,2,2,2,3,3,3,1))
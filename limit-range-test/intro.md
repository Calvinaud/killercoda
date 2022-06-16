This tutorial is the interactive version of this k8s documentation: <https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/cpu-constraint-namespace/>

This tutorial shows how to set minimum and maximum values for the CPU resources used by containers
and Pods in a namespace. You specify minimum
and maximum CPU values in a
[LimitRange](https://kubernetes.io/docs/reference/kubernetes-api/policy-resources/limit-range-v1/)
object. If a Pod does not meet the constraints imposed by the LimitRange, it cannot be created
in the namespace.
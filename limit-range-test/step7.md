## Enforcement of minimum and maximum CPU constraints

The maximum and minimum CPU constraints imposed on a namespace by a LimitRange are enforced only
when a Pod is created or updated. If you change the LimitRange, it does not affect
Pods that were created previously.

## Motivation for minimum and maximum CPU constraints

As a cluster administrator, you might want to impose restrictions on the CPU resources that Pods can use.
For example:

* Each Node in a cluster has 2 CPU. You do not want to accept any Pod that requests
more than 2 CPU, because no Node in the cluster can support the request.

* A cluster is shared by your production and development departments.
You want to allow production workloads to consume up to 3 CPU, but you want development workloads to be limited
to 1 CPU. You create separate namespaces for production and development, and you apply CPU constraints to
each namespace.

## Clean up

Delete your namespace:

```
kubectl delete namespace constraints-cpu-example
```{{exec}}
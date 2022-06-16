As a cluster administrator, you might want to impose restrictions on the CPU resources that Pods can use.
For example:

* Each Node in a cluster has 2 CPU. You do not want to accept any Pod that requests
more than 2 CPU, because no Node in the cluster can support the request.

* A cluster is shared by your production and development departments.
You want to allow production workloads to consume up to 3 CPU, but you want development workloads to be limited
to 1 CPU. You create separate namespaces for production and development, and you apply CPU constraints to
each namespace.


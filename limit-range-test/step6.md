## Create a Pod that does not specify any CPU request or limit

Here's a manifest for a Pod that has one container. The container does not
specify a CPU request, nor does it specify a CPU limit.

```
echo 'apiVersion: v1
kind: Pod
metadata:
  name: constraints-cpu-demo-4
spec:
  containers:
  - name: constraints-cpu-demo-4-ctr
    image: vish/stress' > cpu-constraints-pod-4.yaml
```{{exec}}

Create the Pod:

```
kubectl apply -f cpu-constraints-pod-4.yaml --namespace=constraints-cpu-example
```{{exec}}

View detailed information about the Pod:

```
kubectl get pod constraints-cpu-demo-4 --namespace=constraints-cpu-example --output=yaml
```{{exec}}

The output shows that the Pod's single container has a CPU request of 800 millicpu and a
CPU limit of 800 millicpu.
How did that container get those values?

```yaml
resources:
  limits:
    cpu: 800m
  requests:
    cpu: 800m
```

Because that container did not specify its own CPU request and limit, the control plane
applied the
[default CPU request and limit](https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/cpu-default-namespace/)
from the LimitRange for this namespace.

At this point, your Pod might be running or it might not be running. Recall that a prerequisite for this task is that your cluster must have at least 1 CPU available for use. If each of your Nodes has only 1 CPU, then there might not be enough allocatable CPU on any Node to accommodate a request of 800 millicpu. If you happen to be using Nodes with 2 CPU, then you probably have enough CPU to accommodate the 800 millicpu request.

Delete your Pod:

```
kubectl delete pod constraints-cpu-demo-4 --namespace=constraints-cpu-example
```{{exec}}
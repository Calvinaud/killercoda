Here's a manifest for a Pod that has one container. The container specifies a
CPU request of 500 millicpu and a cpu limit of 1.5 cpu.

```echo 'apiVersion: v1
kind: Pod
metadata:
  name: constraints-cpu-demo-2
spec:
  containers:
  - name: constraints-cpu-demo-2-ctr
    image: nginx
    resources:
      limits:
        cpu: "1.5"
      requests:
        cpu: "500m"' > cpu-constraints-pod-2.yaml
```{{exec}}

Attempt to create the Pod:

```
kubectl apply -f cpu-constraints-pod-2.yaml --namespace=constraints-cpu-example
```{{exec}}

The output shows that the Pod does not get created, because it defines an unacceptable container.
That container is not acceptable because it specifies a CPU limit that is too large:

```
Error from server (Forbidden): error when creating "examples/admin/resource/cpu-constraints-pod-2.yaml":
pods "constraints-cpu-demo-2" is forbidden: maximum cpu usage per Container is 800m, but limit is 1500m.
```
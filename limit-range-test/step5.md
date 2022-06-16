Here's a manifest for a Pod that has one container. The container specifies a
CPU request of 100 millicpu and a CPU limit of 800 millicpu.

```
echo 'apiVersion: v1
kind: Pod
metadata:
  name: constraints-cpu-demo-3
spec:
  containers:
  - name: constraints-cpu-demo-3-ctr
    image: nginx
    resources:
      limits:
        cpu: "800m"
      requests:
        cpu: "100m"' > cpu-constraints-pod-3.yaml
```{{exec}}

Attempt to create the Pod:

```
kubectl apply -f cpu-constraints-pod-3.yaml --namespace=constraints-cpu-example
```{{exec}}

The output shows that the Pod does not get created, because it defines an unacceptable container.
That container is not acceptable because it specifies a CPU limit that is lower than the
enforced minimum:

```
Error from server (Forbidden): error when creating "examples/admin/resource/cpu-constraints-pod-3.yaml":
pods "constraints-cpu-demo-3" is forbidden: minimum cpu usage per Container is 200m, but request is 100m.
```
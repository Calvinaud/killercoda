## Create the pod

Here's a manifest for a Pod that has one container. The container manifest
specifies a CPU request of 500 millicpu and a CPU limit of 800 millicpu. These satisfy the
minimum and maximum CPU constraints imposed by the LimitRange.

```
echo 'apiVersion: v1
kind: Pod
metadata:
  name: constraints-cpu-demo
spec:
  containers:
  - name: constraints-cpu-demo-ctr
    image: nginx
    resources:
      limits:
        cpu: "800m"
      requests:
        cpu: "500m"' > cpu-constraints-pod.yaml
```{{exec}}

Create the Pod:

```
kubectl apply -f cpu-constraints-pod.yaml --namespace=constraints-cpu-example
```{{exec}}

Verify that the Pod is running and that its container is healthy:

```
kubectl get pod constraints-cpu-demo --namespace=constraints-cpu-example
```{{exec}}

View detailed information about the Pod:

```
kubectl get pod constraints-cpu-demo --output=yaml --namespace=constraints-cpu-example
```{{exec}}

The output shows that the Pod's only container has a CPU request of 500 millicpu and CPU limit
of 800 millicpu. These satisfy the constraints imposed by the LimitRange.

```yaml
resources:
  limits:
    cpu: 800m
  requests:
    cpu: 500m
```

## Delete the Pod

```
kubectl delete pod constraints-cpu-demo --namespace=constraints-cpu-example
```{{exec}}
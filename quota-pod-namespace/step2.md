Here is an example manifest for a ResourceQuota:

```
echo 'apiVersion: v1
kind: ResourceQuota
metadata:
  name: pod-demo
spec:
  hard:
    pods: "2"
' > quota-pod.yaml
```{{exec}}

Create the ResourceQuota:

```
kubectl apply -f ./quota-pod.yaml --namespace=quota-pod-example
```{{exec}}

View detailed information about the ResourceQuota:

```
kubectl get resourcequota pod-demo --namespace=quota-pod-example --output=yaml
```{{exec}}

The output shows that the namespace has a quota of two Pods, and that currently there are
no Pods; that is, none of the quota is used.

```yaml
spec:
  hard:
    pods: "2"
status:
  hard:
    pods: "2"
  used:
    pods: "0"
```

Here is an example manifest for a deployment:

```
echo 'apiVersion: apps/v1
kind: Deployment
metadata:
  name: pod-quota-demo
spec:
  selector:
    matchLabels:
      purpose: quota-demo
  replicas: 3
  template:
    metadata:
      labels:
        purpose: quota-demo
    spec:
      containers:
      - name: pod-quota-demo
        image: nginx
' > quota-pod-deployment.yaml
```{{exec}}

In that manifest, `replicas: 3` tells Kubernetes to attempt to create three new Pods, all
running the same application.

Create the Deployment:

```
kubectl apply -f ./quota-pod-deployment.yaml --namespace=quota-pod-example
```{{exec}}

View detailed information about the Deployment:

```
kubectl get deployment pod-quota-demo --namespace=quota-pod-example --output=yaml
```{{exec}}

The output shows that even though the Deployment specifies three replicas, only two
Pods were created because of the quota you defined earlier:

```yaml
spec:
  ...
  replicas: 3
...
status:
  availableReplicas: 2
...
lastUpdateTime: 2021-04-02T20:57:05Z
    message: 'unable to create pods: pods "pod-quota-demo-1650323038-" is forbidden:
      exceeded quota: pod-demo, requested: pods=1, used: pods=2, limited: pods=2'
```

### Choice of resource

In this task you have defined a ResourceQuota that limited the total number of Pods, but
you could also limit the total number of other kinds of object. For example, you
might decide to limit how many CronJobs
that can live in a single namespace.


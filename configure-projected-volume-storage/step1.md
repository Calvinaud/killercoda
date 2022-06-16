In this exercise, you create username and password Secrets from local files. You then create a Pod that runs one container, using a [`projected`](https://kubernetes.io/docs/concepts/storage/volumes/#projected) Volume to mount the Secrets into the same shared directory.

Here is the configuration file for the Pod:

```
echo 'apiVersion: v1
kind: Pod
metadata:
  name: test-projected-volume
spec:
  containers:
  - name: test-projected-volume
    image: busybox:1.28
    args:
    - sleep
    - "86400"
    volumeMounts:
    - name: all-in-one
      mountPath: "/projected-volume"
      readOnly: true
  volumes:
  - name: all-in-one
    projected:
      sources:
      - secret:
          name: user
      - secret:
          name: pass
' > projected.yaml
```{{exec}}

1. Create the Secrets:

```
    # Create files containing the username and password:
    echo -n "admin" > ./username.txt
    echo -n "1f2d1e2e67df" > ./password.txt

    # Package these files into secrets:
    kubectl create secret generic user --from-file=./username.txt
    kubectl create secret generic pass --from-file=./password.txt
```{{exec}}
1. Create the Pod:

```
    kubectl apply -f ./projected.yaml
```{{exec}}
1. Verify that the Pod's container is running, and then watch for changes to
the Pod:

```
    kubectl get --watch pod test-projected-volume
```{{exec}}
    The output looks like this:
    ```
    NAME                    READY     STATUS    RESTARTS   AGE
    test-projected-volume   1/1       Running   0          14s
    ```
1. In another terminal, get a shell to the running container:

```
    kubectl exec -it test-projected-volume -- /bin/sh
```{{exec}}
1. In your shell, verify that the `projected-volume` directory contains your projected sources:

```
    ls /projected-volume/
```{{exec}}


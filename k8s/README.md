# Kubernetes deployment

Everything needed to run `simple-webapp-flask` on Kubernetes lives in this folder.

| File | What it creates |
|---|---|
| `namespace.yaml` | Namespace `flask-webapp` |
| `deployment.yaml` | Deployment with 3 replicas, probes, resource requests/limits, rolling update strategy |
| `service.yaml` | NodePort Service, reachable on `<node-ip>:30080` |
| `pdb.yaml` | PodDisruptionBudget, at most one replica evicted at a time during a node drain |
| `kustomization.yaml` | Ties the files together and sets the image tag |

The commands below are written for the 3-node kubeadm lab (`controlplane` 192.168.56.11, `node01` 192.168.56.21, `node02` 192.168.56.22, containerd runtime). Run `kubectl` and `docker` commands on `controlplane` unless stated otherwise. On another cluster only step 1 changes.

## 1. Build the image and make it available to the nodes

The image version is baked in with a build argument and reported by the `/version` endpoint.

Get the repository onto `controlplane` and build:

```bash
git clone https://github.com/jazibumer-afk/simple-webapp-flask.git
cd simple-webapp-flask

sudo apt-get update && sudo apt-get install -y docker.io   # once, the lab nodes only have containerd
sudo docker build --build-arg APP_VERSION=1.0.0 -t simple-webapp-flask:1.0.0 .
```

The kubelet uses containerd, not Docker, so it cannot see images that Docker built. Pick one of the two options to hand the image over.

### Option A: import the image into every node (no registry)

Export the image to the folder that Vagrant shares with all VMs:

```bash
sudo docker save simple-webapp-flask:1.0.0 -o /vagrant/simple-webapp-flask-1.0.0.tar
```

Import it into containerd's `k8s.io` namespace on **each** node that can run the pods. Run this on `node01` and on `node02`:

```bash
sudo ctr -n k8s.io images import /vagrant/simple-webapp-flask-1.0.0.tar
sudo crictl images | grep simple-webapp-flask
```

Pods are only scheduled on the workers, because `controlplane` is tainted. A worker that does not have the image fails with `ErrImagePull` / `ImagePullBackOff`.

### Option B: push to a registry

```bash
sudo docker login
sudo docker tag simple-webapp-flask:1.0.0 <dockerhub-user>/simple-webapp-flask:1.0.0
sudo docker push <dockerhub-user>/simple-webapp-flask:1.0.0
```

Then point the manifests at it in `kustomization.yaml`:

```yaml
images:
  - name: simple-webapp-flask
    newName: <dockerhub-user>/simple-webapp-flask
    newTag: "1.0.0"
```

## 2. Deploy

```bash
kubectl apply -k k8s/
kubectl -n flask-webapp rollout status deployment/simple-webapp-flask
kubectl -n flask-webapp get deploy,rs,pods,svc,pdb -o wide
```

To see the rendered manifests without applying them: `kubectl kustomize k8s/`.

## 3. Access from outside the cluster

The Service is a NodePort on `30080`, so the app answers on every node's IP. From the Windows host (or any machine on the `192.168.56.0/24` network):

```bash
curl http://192.168.56.21:30080/
curl http://192.168.56.21:30080/how-are-you
curl http://192.168.56.21:30080/version
```

`/version` returns the image version and the pod name. Repeating it shows requests being spread over the replicas.

## 4. Verify availability when a pod is deleted

Terminal 1, keep requests flowing and print the HTTP status:

```bash
while true; do
  curl -s -o /dev/null -w '%{http_code}\n' --max-time 2 http://192.168.56.21:30080/
  sleep 0.5
done
```

Terminal 2, delete one pod and watch the Deployment replace it:

```bash
kubectl -n flask-webapp get pods
kubectl -n flask-webapp delete pod <pod-name>
kubectl -n flask-webapp get pods -w
```

Terminal 1 should keep printing `200`. The other replicas carry the traffic, the deleted pod is taken out of the Service endpoints before it stops (`preStop` sleep), and the ReplicaSet starts a replacement that only receives traffic once its readiness probe passes.

## 5. Scale up and down

```bash
kubectl -n flask-webapp scale deployment/simple-webapp-flask --replicas=5
kubectl -n flask-webapp get pods -o wide
kubectl -n flask-webapp get endpointslices

kubectl -n flask-webapp scale deployment/simple-webapp-flask --replicas=2
kubectl -n flask-webapp get pods -o wide
```

Keep the curl loop from step 4 running to confirm the app stays up. `kubectl scale` is a temporary change: the next `kubectl apply -k k8s/` sets the count back to `replicas` in `deployment.yaml`. To change it for good, edit that file and apply.

## 6. Rolling update to a new version

Build the new version and make it available to the nodes the same way as in step 1:

```bash
sudo docker build --build-arg APP_VERSION=2.0.0 -t simple-webapp-flask:2.0.0 .
sudo docker save simple-webapp-flask:2.0.0 -o /vagrant/simple-webapp-flask-2.0.0.tar
# on node01 and node02:
sudo ctr -n k8s.io images import /vagrant/simple-webapp-flask-2.0.0.tar
```

Set `newTag: "2.0.0"` in `kustomization.yaml`, then:

```bash
kubectl apply -k k8s/
kubectl -n flask-webapp annotate deployment/simple-webapp-flask kubernetes.io/change-cause="release 2.0.0" --overwrite
kubectl -n flask-webapp rollout status deployment/simple-webapp-flask
kubectl -n flask-webapp rollout history deployment/simple-webapp-flask
curl http://192.168.56.21:30080/version
```

With `maxSurge: 1` and `maxUnavailable: 0`, Kubernetes starts one new pod, waits until it is Ready for `minReadySeconds`, and only then removes one old pod. Capacity never drops below 3 replicas, and the curl loop from step 4 keeps returning `200` throughout. Commit the tag change so the repository matches the cluster.

Without editing files, the same update is `kubectl -n flask-webapp set image deployment/simple-webapp-flask webapp=simple-webapp-flask:2.0.0`.

## 7. Roll back

```bash
kubectl -n flask-webapp rollout history deployment/simple-webapp-flask
kubectl -n flask-webapp rollout undo deployment/simple-webapp-flask
# or to a specific revision:
kubectl -n flask-webapp rollout undo deployment/simple-webapp-flask --to-revision=1

kubectl -n flask-webapp rollout status deployment/simple-webapp-flask
curl http://192.168.56.21:30080/version
```

The rollback is itself a rolling update, so the app stays available. Afterwards set `newTag` in `kustomization.yaml` back to the version that is running, otherwise the next `kubectl apply -k k8s/` rolls forward again.

A rollout that is stuck (for example on a bad image) never takes down the old pods. Roll it back the same way with `rollout undo`.

## 8. Remove

```bash
kubectl delete -k k8s/
```

This deletes the namespace and everything in it. To also remove the image from a node: `sudo crictl rmi simple-webapp-flask:1.0.0`.

## Troubleshooting

Start with these three commands. The `Events` section at the bottom of `describe` usually names the problem.

```bash
kubectl -n flask-webapp get pods -o wide
kubectl -n flask-webapp describe pod <pod-name>
kubectl -n flask-webapp get events --sort-by=.lastTimestamp
```

| Symptom | Likely cause | Check or fix |
|---|---|---|
| `ErrImagePull` / `ImagePullBackOff` | The image is not on the node the pod landed on, or the tag is wrong | `sudo crictl images \| grep simple-webapp` on that node, then import it (step 1). The import must go into the `k8s.io` namespace: `ctr -n k8s.io` |
| `Pending` | No node can take the pod: not enough CPU/memory, or only tainted nodes are left | `kubectl describe pod` shows the scheduler's reason. `kubectl describe node <node>` shows allocated resources and taints |
| `CrashLoopBackOff` | The application fails to start | `kubectl -n flask-webapp logs <pod-name> --previous` |
| `OOMKilled` in `describe pod` | Memory limit of 128Mi is too low | Raise `resources.limits.memory` in `deployment.yaml` |
| `Running` but `0/1` Ready | Startup or readiness probe is failing | `describe pod` lists probe failures. Test from inside the cluster: `kubectl -n flask-webapp port-forward <pod-name> 5000:5000` and `curl localhost:5000/healthz` |
| `CreateContainerConfigError` mentioning non-root | The image was not built from this Dockerfile and runs as root | Rebuild with this repository's Dockerfile |
| Service does not answer | Service selector does not match the pod labels, so it has no endpoints | `kubectl -n flask-webapp get endpointslices` must list pod IPs. Compare `kubectl get pods --show-labels` with the selector in `service.yaml` |
| Works inside the cluster, not on `<node-ip>:30080` | Wrong IP, or a network problem between host and nodes | `kubectl get nodes -o wide` and `kubectl -n flask-webapp get svc`. Test in-cluster first: `kubectl -n flask-webapp run tmp --rm -it --restart=Never --image=busybox -- wget -qO- http://simple-webapp-flask/version`. If that works, try each node IP on port 30080 and check `kube-proxy` and Calico pods in `kube-system` |
| `nodePort: 30080` already allocated | Another Service uses the port | Change `nodePort` in `service.yaml` (range 30000-32767) |
| Rollout hangs | New pods never become Ready | `kubectl -n flask-webapp rollout status ...`, then the pod checks above. Roll back with `rollout undo` |

Resource usage (`kubectl top pods -n flask-webapp`) needs metrics-server, which the lab does not install by default.

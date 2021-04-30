---
#Group of NFS Server Pods
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: nfs-servers
  labels:
    k8s-app: nfs-pods
    tag: nfs-pods-test
spec:
  replicas: 3
  template:
    metadata:
      name: nfs-server
      labels:
        k8s-app: nfs-pods
        tag: nfs-pods-test
    spec:
      containers:
      - name: nfs-server
        image: gcr.io/google-samples/nfs-server:1.1
        ports:
          - name: nfs
            containerPort: 2049
          - name: mountd
            containerPort: 20048
          - name: rpcbind
            containerPort: 111
        securityContext:
          privileged: true
---
#Group of Pods NFS Service
kind: Service
metadata:
  name: nfs-pods-service
  labels:
    app: mine
    tag: nfs-pods-test
spec:
  ports:
    - name: nfs
      port: 2049
      protocol: TCP
    - name: mountd
      port: 20048
      protocol: TCP
    - name: rpcbind
      port: 111
      protocol: TCP
  selector:
    k8s-app: nfs-pods
    tag: nfs-pods-test
---
#Group of Pods NFS client
apiVersion: v1
kind: Pod
metadata:
  name: nfs-pods-clientt
  labels:
    name: nfs-pods-client
    tag: nfs-pods-test
spec:
  containers:
  - name: app-pod
    image: redis
    volumeMounts:
    - name: webapp
      mountPath: /mnt
  volumes:
  - name: webapp
    nfs:
      # FIXME: The ip or domain of nfs-pods-service
      server: nfs-pods-service.default.svc.cluster.local
      path: "/exports"
      readOnly: false
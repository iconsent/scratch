# Kubernetes Jobs POC
The Control-M folders will be mounted as a NFS mount.
In Kubernetes (k8s), NFS based persistent volumes can be used inside the pods.

List of pods:

1. SFTP pod: this will run a SFTP server
2. CronJob - Batch-Processor: This pod will be created to process the files uploaded in the SFTP folder
3. NFS server - this pod will run a NFS server. It will expose a NFS PV 
4. Busybox pod to connect to the SFTP server

This demo can run within Rancher and GKE Anthos. This has been tested in Azure AKE

    sh azure/create_cluster.sh
    kubectl apply -f nfs-service.yaml
    kubectl apply -f nfs-pv.yaml
    kubectl apply -f nfs-pvc.yaml
    kubectl apply -f sftp.yaml
    kubectl apply -f cronjob.yaml
    read

    kubectl delete -f cronjob.yaml
    kubectl delete -f sftp.yaml
    kubectl delete -f nfs-pvc.yaml
    kubectl delete -f nfs-pv.yaml
    kubectl delete -f nfs-service.yaml
    sh azure/delete_cluster.sh

    apt-get update && apt install nfs-common dnsutils # to mount the nfs
    
## Install airflow

- Using helm [install](https://helm.sh/docs/intro/install/)

https://github.com/airflow-helm/charts/tree/main/charts/airflow


## Access airfow

export POD_NAME=$(kubectl get pods --namespace default -l "component=web,app=airflow" -o jsonpath="{.items[0].metadata.name}")
  echo "URL: http://127.0.0.1:8080"
  kubectl port-forward --namespace default $POD_NAME 8080:8080

Setup an ingress for the airflow


## References:
[NFS mount](https://github.com/kubernetes/examples/tree/master/staging/volumes/nfs)

https://www.digitalocean.com/community/tutorials/how-to-set-up-readwritemany-rwx-persistent-volumes-with-nfs-on-digitalocean-kubernetes
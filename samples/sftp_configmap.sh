mkdir keys
ssh-keygen -f ./keys/id_rsa -P ""

#public ssh keys
kubectl delete configMap sftp-public-keys || true #if error, just carry on
kubectl create configmap sftp-public-keys \
  --from-file=./keys || true
#az provider unregister --namespace Microsoft.OperationsManagement
#az provider unregister --namespace Microsoft.OperationalInsights

az group delete --name myResourceGroup --yes --no-wait
az aks delete --resource-group myResourceGroup --name myAKSCluster

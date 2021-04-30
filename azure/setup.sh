az group create --name myResourceGroup --location eastus

az provider register --namespace Microsoft.OperationsManagement
az provider register --namespace Microsoft.OperationalInsights

az provider show -n Microsoft.OperationsManagement -o table
az provider show -n Microsoft.OperationalInsights -o table

az aks install-cli
az aks get-credentials --resource-group myResourceGroup --name myAKSCluster

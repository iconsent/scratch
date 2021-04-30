#curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
#chmod 700 get_helm.sh
#./get_helm.sh

export RELEASE_NAME=airflow # set a name!
export NAMESPACE=default # set a namespace!
export CHART_VERSION=8.0.9 # set a version!
export VALUES_FILE=./custom-values.yaml # set your values file path!

# Helm 3
helm install \
  $RELEASE_NAME \
  airflow-stable/airflow \
  --namespace $NAMESPACE \
  --version $CHART_VERSION \
  --values $VALUES_FILE \
  --set dags.persistence.enabled=true \
	--set dags.persistence.existingClaim=azure-managed-disk \
  --set dags.gitSync.enabled=false
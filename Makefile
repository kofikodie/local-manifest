port-forward: 
	KUARD_POD=$(kubectl get pods -l app=kuard -o jsonpath='{.items[0].metadata.name}')
	kubectl port-forward $KUARD_POD 30080:8080
tls-screct: 
	kubectl create secret generic kuard-tls \
	--from-file=charts/certs/kuard.crt \
	--from-file=charts/certs/kuard.key
update-cm:
	kubectl create configmap my-config \
	--from-file=kuard-config.yml \
	--dry-run=client -o yaml | kubectl apply -f -
plg-repo:
	helm repo add grafana https://grafana.github.io/helm-charts
	helm repo update
	helm show values grafana/loki-stack > ./charts/plg/loki-stack-values.yml
plg-install:
	helm install loki grafana/loki-stack -n loki --create-namespace -f ./charts/plg/loki-stack-values.yml
plg-password:
	kubectl get secret loki-grafana -n loki \
	-o template \
	--template '{{ index .data "admin-password" }}' | base64 -d; echo
plg-forward:
	kubectl port-forward service/loki-grafana 3000:80 -n loki
plg-delete:
	helm uninstall loki -n loki
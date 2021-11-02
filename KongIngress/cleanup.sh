
kubectl config set-context --current --namespace cre
kubectl delete -f https://bit.ly/sample-echo-service
kubectl delete -f ../Ingress/simple-ingress.yaml
kubectl delete -f kong-ingress-route-redirect.yaml
kubectl delete -f kong-ingress-service-retries.yaml
kubectl delete -f kong-ingress-hash-on-ip.yaml


# Create some sample deployments and services, echo and httpbin
kubectl apply -f https://bit.ly/sample-echo-service
kubectl apply -f https://bit.ly/sample-httpbin-service


# Create a Kubernetes Ingress resource
kubectl apply -f simple-ingress.yaml


# Create some KongIngress resources to extend the Kubernetes Ingress resource. This allows deeper customization like
# hash on ip or stripping the path before routing
kubectl apply -f kong-ingress-strip-path.yaml
kubectl apply -f kong-ingress-hash-on-ip.yaml


# Patch the existing Kubernetes Ingress resource to use the KongIngress annoation (associate the KongIngress to the Kubernetes Ingress)
kubectl patch ingress demo -p '{"metadata":{"annotations":{"konghq.com/override":"strip-path"}}}'
kubectl patch service echo -p '{"metadata":{"annotations":{"configuration.konghq.com":"hash-on-ip"}}}'


# Add the ip restriction plugin to the route
kubectl apply -f ip-restriction-per-route.yaml


kubectl patch service echo -p '{"metadata":{"annotations":{"konghq.com/plugins":"ip-route-plugin"}}}'
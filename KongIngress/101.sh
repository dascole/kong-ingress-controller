# Change contexts
kubectl config set-context --current --namespace cre

cd /home/joe/Documents/Training/TechTalks/KIC/KongIngress/

# Create the echo deployment
kubectl apply -f https://bit.ly/sample-echo-service

# Create a simple Ingress
kubectl apply -f ../Ingress/simple-ingress.yaml

# Test the route
PROXY=$(kubectl get svc kongfu-kong-proxy -o jsonpath='{.spec.clusterIP}')
curl http://$PROXY/echo
curl https://$PROXY:443/echo -k

# Setup the route to use ONLY HTTPS and change the redirect code from the default of 426 to 302
kubectl apply -f kong-ingress-route-redirect.yaml

# To affect a route we need to update the Ingress resource. We must added the annotation konghq.com/override
kubectl patch ingress demo -p '{"metadata":{"annotations":{"konghq.com/override":"route-redirect"}}}'

# We can view the annotation added
kubectl get ing demo -o yaml | head -n5

# Test the route over HTTP and HTTPS, we expect a 302 message when using HTTP
curl http://$PROXY/echo -i
curl https://$PROXY:443/echo -k




# Change the upstream properties to include 'hash on ip'
kubectl apply -f kong-ingress-hash-on-ip.yaml

# Patch the Kubernetes service to affect the Kong Service
kubectl patch service echo -p '{"metadata":{"annotations":{"konghq.com/override":"hash-on-ip"}}}'





# Increase the service retries from the default of 5 to 20
kubectl apply -f kong-ingress-service-retries.yaml

# Patch the Kubernetes service to affect the Kong Service
kubectl patch service echo -p '{"metadata":{"annotations":{"konghq.com/override":"svc-retries"}}}'

# We can view the annotation added
kubectl get svc echo -o yaml | head -n5








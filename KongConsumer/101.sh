# https://github.com/Kong/kubernetes-ingress-controller/tree/d8f58ead71664b042c854c1a3e429fe95f17eb24/test/integration/cases

# Cred Types
    # key-auth
    # keyauth_credential
    # basic-auth
    # basicauth_credential
    # hmac-auth
    # hmacauth_credential
    # jwt
    # jwt_secret
    # oauth2
    # acl               
    # mtls-auth        



# Change contexts
kubectl config set-context --current --namespace cre


PROXY=$(kubectl get svc kongfu-kong-proxy -o jsonpath='{.spec.clusterIP}')
curl https://$PROXY:443/echo -k


# Create a basic auth plung for our route
kubectl apply -f ../Plugins/key-auth/key-auth.yaml

# Update our route to use the plugin
kubectl patch ingress demo -p '{"metadata":{"annotations":{"konghq.com/plugins":"key-auth"}}}'

# Create a consumer, joe
kubectl apply -f kong-consumer.yaml


# Create a Credential for the user
kubectl create secret generic apikey --from-literal=kongCredType=key-auth --from-literal=key=ABC123

# View the secret
kubectl get secrets apikey -o jsonpath='{.data}' | jq
kubectl get secrets apikey -o jsonpath='{.data.key}' | base64 -d

# Make sure the route is protected
curl https://$PROXY:443/echo -k


# Pass in a valid API Key to make sure things work OK
curl https://$PROXY:443/echo?apikey=ABC123 -k
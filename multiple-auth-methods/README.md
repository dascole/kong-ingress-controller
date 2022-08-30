# Multiple Authentication Methods
https://docs.konghq.com/gateway/latest/configure/auth/allowing-multiple-authentication-methods/#main

1. Apply the services, consumers and ingresses
2. Update the plugins/oidc.yaml line 8 with the anonymous user UUID
3. Apply the oidc.yaml
4. Test the auth methods for all 3 scenarios
  - curl http://<host>:<port>/anything
  - curl http://<host>:<port>/anything?apikey=kong
  - curl -H "Authorization: Bearer xyz http://<host>:<port>/anything

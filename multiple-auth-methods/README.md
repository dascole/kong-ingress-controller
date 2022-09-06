# Multiple Authentication Methods
https://docs.konghq.com/gateway/latest/configure/auth/allowing-multiple-authentication-methods/#main

This example uses Google for the OIDC Provider. You will need to make modifications as needed for your own provider

The consumer MCCLANE is a placeholder and should be updated with your EMAIL address from Google.
i.e: 

username: xyz@domain.com

1. Apply the secret, service, consumers and ingress
   $ kubectl apply -f services/ -f consumers/ -f ingresses/ -f secrets/
2. Update the plugins/oidc.yaml line 8 with the anonymous user UUID
3. Apply the plugins
   $ kubectl apply -f plugins
4. Obtain a testing token from Google:
   a. Navigate to https://developers.google.com/oauthplayground
   b. In the lower left side there is a text box with the placeholder text "input your own scopes", here enter: openid email
   c. Click 'Authorize APIs'
   d. Login to your account/approve the request
   e. Click 'Exchange authorization code for tokens' and an id_token will be returned with an email claim.
   
5. Test the auth methods for all 3 scenarios
  a. curl http://\<host\>:\<port\>/anything      						-- should fail 
  b. curl http://\<host\>:\<port\>/anything?apikey=ABC123				-- should succeed with Key Auth
  c. curl -H "Authorization: Bearer \<token from step 4e above\> http://\<host\>:\<port\>/anything


charm
=====
Works like a charm

#Charm is OAuth2.a based implementation of Provider.

OAuth2.a is slightly different from OAuth2. There are lots of simplifications, KISS improvements and security adjustments. Also - new features! 

Enjoy the spec!

Client - an application or a website that needs access to User's resources.

Client credentials - client_id and client_secret(shared secret between Provider and Client)

Resource Owner(or just User) - grants access to his resources on Provider to Client. 

Provider - an application(rather "platform") that implements some API and has OAuth2.a interface to authorize Clients.

Token - random string, identifies relationship between Client and User. Token is united entity of code(from Authorization flow), refresh_token and access_token. When token is expired you use it with client credentials to obtain new token.

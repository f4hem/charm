charm
=====
Works like a charm

#Charm is OAuth2.a based implementation of Provider.

OAuth2.a is slightly different from OAuth2. There are lots of simplifications, KISS improvements and security adjustments. Also - new features! 

Client - an application or a website that needs access to User's resources.

Client credentials - client_id and client_secret(shared secret between Provider and Client)

Resource Owner(or just User) - grants access to his resources on Provider to Client. 

Provider - an application(rather "platform") that implements some API and has OAuth2.a interface to authorize Clients.

Token - random string, identifies relationship between Client and User. Token is united entity of code(from Authorization flow), refresh_token and access_token. When token is expired you use it with client credentials to obtain new token.

Authorization process in #OAuth2a:

### Client redirects user to `PROVIDER/charm/authorize` URL with following parameters:
* client_id (required)
Identificator of your application
* scope (optional)
Useful if scopes of your application are agile and User chooses what to allow and what to deny.
* valid_thru (optional)
This parameter specifies for how many seconds you need to have access to User's Resources. This is different from expire_at - when Token gets invalid authorization is just removed and you will need to ask authorization again
* display (optional)
Any Provider-specific data, for example how page should be rendered - popup|page
* state (optional)
Any arbitary string, will be sent back on Client's redirect_uri. Should be used to prevent CSRF attack(send random value and save it in user's session. when he is back check equality).

### User clicks either Accept or Reject. If User has granted authorization for your application:
if response_type is 'code'
Provider creates a new _expired_ token for your Client that gives access to Resources. User is redirected back to your application with following parameters:
* token
That token is already expired and you just need to refresh it right away. Use steps for refreshing described below.
* scope
Scopes accepted by User.
* state
Arbitary string you sent in authorization URL.

if response_type is 'token'
You will get token(not expired), state(if used) and expire_at params on your redirect_uri in hashbang(#). location.hash is not sent on server-side thus you will need to extract it with javascript and then use.

### When you get a token first time with response_type=code and when some tokens are expired you need to refresh them at `PROVIDER/charm/token` with following params:
* client_id and client_secret (required, client credentials)
* token (required, it may be a string or an array of tokens for _mass refreshing_).
Example:
request:

```
{
	client_id: '1',
	client_secret: 's3c3r3t',
	token: [
	  '123asdf..',
	  '23423ds..',
	  ...
	]
}
```

response:

```
{
	expire_in: 123123,
	token: [
	  'new 123asdf..',
	  'new 23423ds..',
	  ...
	]
}
```

# When you have valid and not expired token you can use it to call Provider's API:
`API_DOMAIN/API_PATH/me?token=TOKEN`


Every Client has 1 redirect_uri, 1 scope and 1 response_type. They are defined in settings of application and cannot be changed during authorization process(scope can be adjusted if it's not "fixed"). 


#Roadmap
* subrequests: include the following api call in token refresh request and get data with less round trips



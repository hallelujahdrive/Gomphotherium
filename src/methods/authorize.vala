namespace Valastodon {
	
	// Users have to go to this url's web page to authorize a your app
	// @instance_website : URL to Instance you want to regist 
	// @redirect_uri : (nullable) Where the user should be redirected after authorization
	// @scope : This can be a space-separated list of the following items: "read", "write" and "follow"
	public string get_authorize_url (string instance_website, string scope, string? redirect_uri, string client_key) {
		
		if (redirect_uri == null) {
			redirect_uri = "urn:ietf:wg:oauth:2.0:oob";
		}
		
		var sb = new StringBuilder (instance_website);
		sb.append (ENDPOINT_OAUTH_AUTHORIZE);
		sb.append ("?");
		sb.append (PARAM_SCOPE);
		sb.append ("=");
		sb.append (scope.replace(" ", "%20"));
		sb.append ("&");
		sb.append (PARAM_RESPONSE_TYPE);
		sb.append ("=");
		sb.append ("code");
		sb.append ("&");
		sb.append (PARAM_REDIRECT_URI);
		sb.append ("=");
		sb.append (redirect_uri);
		sb.append ("&");
		sb.append (PARAM_CLIENT_ID);
		sb.append ("=");
		sb.append (client_key);
				
		return sb.str;		
	}
}

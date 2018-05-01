using Json;
using Rest;

namespace Valastodon { 
	
	// A result value of register app
	public struct RegisterResult {
		string id;
		string client_key;
		string client_secret;
	}
	
	// Registering a your app
	// @instance_website : URL to Instance you want to regist 
	// @client_name : Name of your ValastodonApp
	// @redirect_uris : (nullable) Where the user should be redirected after authorization
	// @scopes : This can be a space-separated list of the following items: "read", "write" and "follow"
	// @app_website : (nullable) URL to the homepage of your app
	public RegisterResult register_app (string instance_website, string client_name,string? redirect_uris, string scopes, string? app_website = null) throws Error {
				
		var proxy = new Rest.Proxy (instance_website, false);
		var proxy_call = proxy.new_call ();
		
		setup_oauth_proxy_call (ref proxy_call, client_name, redirect_uris, scopes, app_website);
		
		try {
			proxy_call.run ();
			var json_obj = parse_json_object (proxy_call.get_payload ());
			RegisterResult result = {json_obj.get_string_member (PARAM_ID), json_obj.get_string_member (PARAM_CLIENT_ID), json_obj.get_string_member (PARAM_CLIENT_SECRET)};		
			
			return result;
		} catch (Error e) {
			throw e;
		}
	}
	
	// Registing an ValastodonApp asynchronously
	public async RegisterResult register_app_async (string instance_website, string client_name,string? redirect_uris, string scopes, string? app_website = null) throws Error {		
		Error error = null;
		
		var proxy = new Rest.Proxy (instance_website, false);
		var proxy_call = proxy.new_call ();
		
		setup_oauth_proxy_call (ref proxy_call, client_name, redirect_uris, scopes, app_website);
		
		var result = RegisterResult ();

		proxy_call.invoke_async.begin (null, (obj, res) => {
			try {  
				proxy_call.invoke_async.end (res);
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				result = {json_obj.get_string_member (PARAM_ID), json_obj.get_string_member (PARAM_CLIENT_ID), json_obj.get_string_member (PARAM_CLIENT_SECRET)};		
				
			} catch (Error e) {
				error = e;
			}
				
			register_app_async.callback ();
				
		});

		yield;
		
		if (error != null) {
			throw error;
		}
			
		return result;
	}
	
	// set params
	private void setup_oauth_proxy_call (ref ProxyCall proxy_call, string client_name, string? redirect_uris, string scopes, string? website) {
			
	// for no redirect, use urn:ietf:wg:oauth:2.0:oob
	if (redirect_uris == null) {
		redirect_uris = "urn:ietf:wg:oauth:2.0:oob";
	}
	
	proxy_call.add_params (PARAM_CLIENT_NAME, client_name, PARAM_REDIRECT_URIS, redirect_uris, PARAM_SCOPES, scopes);
	
	if (website != null) {
		proxy_call.add_param (PARAM_WEBSITE, website);
	}
	
	proxy_call.set_function (ENDPOINT_APPS);
	proxy_call.set_method ("POST");

	}
	
	public void authorize_app (string instance_website, string client_id, string scope) {
					
		var proxy = new Rest.Proxy (instance_website, false);
		var proxy_call = proxy.new_call ();
		
		proxy_call.add_params (PARAM_CLIENT_ID, client_id, PARAM_RESPONSE_TYPE, "code", PARAM_REDIRECT_URIS, "urn:ietf:wg:oauth:2.0:oob", PARAM_SCOPE, scope);

		proxy_call.set_function (ENDPOINT_OAUTH_AUTHORIZE);
		proxy_call.set_method ("POST");

		try {
			proxy_call.run ();
			print (proxy_call.get_payload ());
			
		} catch (Error e) {
			// throw e;
			stderr.printf ("%s\n", e.message);
		}
	}
}

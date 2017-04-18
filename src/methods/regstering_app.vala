using Json;
using Rest;
using Soup;

using Gomphoterium.RegisteringUtils;

namespace Gomphoterium { 
  // Registing an GomphoApp
  // @instance_website : URL to Instance you want to regist 
  // @client_name : Name of your GomphoApp
  // @redirect_uris : (nullable) Where the user should be redirected after authorization
  // @scope : This can be a space-separated list of the following items: "read", "write" and "follow"
  // @app_website : (nullable) URL to the homepage of your app
  public Gomphoterium.GomphoApp registering_app (string instance_website, string client_name,string? redirect_uris, string scopes, string? app_website = null) throws Error {
        
    var proxy = new Rest.Proxy (instance_website, false);
    var proxy_call = proxy.new_call ();
    
    setup_proxy_call (ref proxy_call, client_name, redirect_uris, scopes, app_website);
    
    try {
      proxy_call.run ();
      var json_obj = parse_json_object (proxy_call.get_payload ());
      
      string client_id = json_obj.get_string_member ("client_id");
      string client_secret = json_obj.get_string_member ("client_secret");
      var app = new GomphoApp (instance_website, client_id, client_secret);
      
      return app;
    } catch (Error e) {
      throw e;
    }
  }
  
  // Registing an GomphoApp asynchronously
  public async GomphoApp registering_app_async (string instance_website, string client_name,string? redirect_uris, string scopes, string? app_website) throws Error {
    
    Error error = null;
    
    var proxy = new Rest.Proxy (instance_website, false);
    var proxy_call = proxy.new_call ();
    
    setup_proxy_call (ref proxy_call, client_name, redirect_uris, scopes, app_website);
    
    GomphoApp app = null;

    proxy_call.invoke_async.begin (null, (obj, res) => {
      try {  
        proxy_call.invoke_async.end (res);
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        
        string client_id = json_obj.get_string_member ("client_id");
        string client_secret = json_obj.get_string_member ("client_secret");
        app = new GomphoApp (instance_website, client_id, client_secret);
        
      } catch (Error e) {
        error = e;
      }
        
      registering_app_async.callback ();
        
      });

    yield;
    
    if (error != null) {
        throw error;
    }
      
    return app;
  }
  
    namespace RegisteringUtils {
      
      // set params
      private void setup_proxy_call (ref ProxyCall proxy_call, string client_name, string? redirect_uris, string scopes, string? website) {
          
      // for no redirect, use urn:ietf:wg:oauth:2.0:oob
      if (redirect_uris == null) {
        redirect_uris = "urn:ietf:wg:oauth:2.0:oob";
      }
      
      proxy_call.add_params (PARAM_CLIENT_NAME, client_name, PARAM_REDIRECT_URIS, "urn:ietf:wg:oauth:2.0:oob", PARAM_SCOPES, scopes);
      
      if (website != null) {
        proxy_call.add_param (PARAM_WEBSITE, website);
      }
      
      proxy_call.set_function (ENDPOINT_APPS);
      proxy_call.set_method ("POST");
    }
  }
}

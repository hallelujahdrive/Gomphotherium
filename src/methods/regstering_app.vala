using Json;
using Rest;
using Soup;

using Gomphoterium.RegisteringUtils;

namespace Gomphoterium { 
  // Registing an Application
  // @instance_website : URL to Instance you want to regist 
  // @client_name : Name of your application
  // @redirect_uris : Where the user should be redirected after authorization (for no redirect, use urn:ietf:wg:oauth:2.0:oob)
  // @scope : This can be a space-separated list of the following items: "read", "write" and "follow"
  // @app_website : URL to the homepage of your app
  public Gomphoterium.Application registering_app (string instance_website, string client_name,string? redirect_uris, string scopes, string? app_website) throws Error {
        
    var proxy = new Rest.Proxy (instance_website, false);
    var proxy_call = proxy.new_call ();
    
    setup_proxy_call (ref proxy_call, client_name, redirect_uris, scopes, app_website);
    
    try {
      proxy_call.run ();
      var json_obj = parse_json_data (proxy_call.get_payload ().data);
      
      string client_id = json_obj.get_string_member ("client_id");
      string client_secret = json_obj.get_string_member ("client_secret");
      var app = new Application (instance_website, client_id, client_secret);
      
      return app;
    } catch (Error e) {
      throw e;
    }
  }
  
  // Registing an Application asynchronously
  public async Application registering_app_async (string instance_website, string client_name,string? redirect_uris, string scopes, string? app_website) throws Error {
    
    var loop = new MainLoop ();
    
    var proxy = new Rest.Proxy (instance_website, false);
    var proxy_call = proxy.new_call ();
    
    setup_proxy_call (ref proxy_call, client_name, redirect_uris, scopes, app_website);
    
    Application app = null;
    try {
      proxy_call.invoke_async.begin (null, (obj, res) => {
        
        proxy_call.invoke_async.end (res);
        
        var json_obj = parse_json_data (proxy_call.get_payload ().data);
        
        string client_id = json_obj.get_string_member ("client_id");
        string client_secret = json_obj.get_string_member ("client_secret");
        app = new Application (instance_website, client_id, client_secret);
        
        registering_app_async.callback ();
        
      });
    } catch (Error e) {
      throw e;
    }
    yield;
    
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

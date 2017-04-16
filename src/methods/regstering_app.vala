using Json;
using Soup;

using Gomphoterium.RegisteringUtils;

namespace Gomphoterium {
  // Callback passed to registering_app_async
  public delegate void RegisteringCallback (Application app);
  
  // Registing an Application
  // @instance_website : URL to Instance you want to regist 
  // @client_name : Name of your application
  // @redirect_uris : Where the user should be redirected after authorization (for no redirect, use urn:ietf:wg:oauth:2.0:oob)
  // @scope : This can be a space-separated list of the following items: "read", "write" and "follow"
  // @app_website : URL to the homepage of your app
  public Gomphoterium.Application? registering_app (string instance_website, string client_name,string? redirect_uris, string scopes, string? app_website) {
    
    var session = new Soup.Session ();
    var message = new Soup.Message ("POST", instance_website + METHOD_APPS);
    
    var buffer = Soup.MemoryUse.STATIC;
    var params = build_paramas (client_name, redirect_uris, scopes, app_website);
    
    message.set_request ("application/x-www-form-urlencoded", buffer, params.data);

    session.send_message (message);
    
    var json_obj = parse_regist_json (message.response_body.data);
    
    if (json_obj != null) {
      
      var client_id = json_obj.get_string_member ("client_id");
      var client_secret = json_obj.get_string_member ("client_secret");
      var app = new Application (instance_website, client_id, client_secret);
      
      return app;
    }
    
    return null;
  }
  
  // Async method
  public async Application? registering_app_async (string instance_website, string client_name,string? redirect_uris, string scopes, string? app_website) {
    
    var session = new Soup.Session ();
    var message = new Soup.Message ("POST", instance_website + METHOD_APPS);
    
    var buffer = Soup.MemoryUse.STATIC;
    var params = build_paramas (client_name, redirect_uris, scopes, app_website);
    
    message.set_request ("application/x-www-form-urlencoded", buffer, params.data);
    
    Application app = null;
    
    SourceFunc callback = registering_app_async.callback;
    
    ThreadFunc<void*> run = () => {
      var loop = new MainLoop ();
      session.queue_message (message, (sess, mess) => {
        var json_obj = parse_regist_json (mess.response_body.data);
        if (json_obj != null) {
        
          var client_id = json_obj.get_string_member ("client_id");
          var client_secret = json_obj.get_string_member ("client_secret");
          app = new Application (instance_website, client_id, client_secret);
          loop.quit ();
        }
      });
      loop.run ();
      Idle.add ((owned) callback);
      return null;
    };
    
    new Thread<void*> (null, run);
    
    yield;
    return app;
  }
  
  namespace RegisteringUtils {
  
    // Parse regist json
    private Json.Object? parse_regist_json (uint8[] regist_data) {
      
      try {
        var parser = new Json.Parser ();
        parser.load_from_data ((string) regist_data, -1);
        
        var root_object = parser.get_root ().get_object();
        if (root_object != null) {
          return root_object;
        }
      } catch (Error e) {
        stderr.printf ("Parse Error : json data could not parse.");
      }
      
      return null;
    }
    
    // Build params
    private string build_paramas (string client_name, string? redirect_uris, string scopes, string? website) {
        
    // for no redirect, use urn:ietf:wg:oauth:2.0:oob
    if (redirect_uris == null) {
      redirect_uris = "urn:ietf:wg:oauth:2.0:oob";
    }
    
    var params = OPTION_CLIENT_NAME + "=" + client_name + "&" + OPTION_REDIRECT_URIS + "=" + redirect_uris + "&" + OPTION_SCOPES + "=" + scopes;
    
    if (website != null) {
      params = params + "& " + OPTION_WEBSITE + "=" + website;
    }
    
    return params;
    
    }
  }
}

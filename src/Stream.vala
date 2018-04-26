using Json;
using Rest;

namespace Valastodon {
  
  public abstract class StreamBase : GLib.Object {

    // Property-backing fields
    protected string _website;
    protected string _client_id;
    protected string _client_secret;
    protected string _access_token;
    
    protected Rest.Proxy proxy;
    protected ProxyCall proxy_call;

    // Propaties   
    public string website {
      get { return _website; }
    }
    public string client_id {
      get { return _client_id; }
    }
    public string client_secret {
      get { return _client_secret; }
    }
    public string access_token {
      get { return _access_token; }
    }
    
    // StringBuilder to build payloads
    private StringBuilder string_builder = new StringBuilder ();
    
    private StreamCallback stream_callback;
    
    private Error _error;
    
    public StreamBase (string website, string client_id, string client_secret, string? access_token) {
      _website = website;
      _client_id = client_id;
      _client_secret = client_secret;
      
      proxy = new Rest.Proxy (_website, false);
      
      if (access_token != null){
        _access_token = access_token;
      }
    }
    
    public StreamBase.new_for_gompho_app (ValastodonAppBase app) {
      this (app.website, app.client_id, app.client_secret, app.access_token);
    }
    
    protected bool continuous_body (owned StreamCallback cb) throws Error {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_method("GET");  
      
      stream_callback = (owned) cb;
      
      try {
        
        return proxy_call.continuous (continuous_proxy_callback, proxy_call);
        
      } catch (Error e) {
        throw e;
      }  
    }
    
    // ProxyCallContinuousCallback does not allow 'buf' is null.
    private void continuous_proxy_callback (ProxyCall call, string? buf, size_t len, Error? error, GLib.Object? weak_object) {
      
      stdout.printf ("%u : %s\n", call.get_status_code (), call.get_status_message ());
      
      if (error != null) {
        _error = error;
        return;
      }
      
      if (buf != null) {
        string fragment = buf.substring(0, (int) len);
        string_builder.append (fragment);
        
        
        if (fragment.has_prefix (":thump")) { // ':thump' is a heartbeat
          string_builder.erase ();
        } else if (fragment.has_suffix ("\r\n") || fragment.has_suffix ("\n\n")) {
          string event_type;
          Valastodon.Object object;
          
          if (parse_payload (string_builder.str, out event_type, out object)) {
              stream_callback (event_type, object);
          }
          
          string_builder.erase ();
        }
      }
    }
    
    private bool parse_payload (string payload, out string event_type, out Valastodon.Object object) {
      
      event_type = null;
      object = null;
      
      string[] lines = payload.split ("\n");
      
      if (lines[0] == "<html>") {
        object = new StreamHead (payload);
        return true;
      }
      
      // lines[0] : event: ...
      event_type = lines[0].substring (7);
      
      try {
        // lines[1] : data: ...
        string data = lines[1].substring (6);
        
        switch (event_type) {
          case EVENT_TYPE_DELETE : object = new Delete (int64.parse (data));
          break;
          case EVENT_TYPE_NOTIFICATION : object = new Notification (parse_json_object (data));
          break;
          case EVENT_TYPE_UPDATE : object = new Status (parse_json_object (data));
          break;
        }

        return object != null;
        
      } catch (Error e) {
        return false;
      }
    }
  }
  
  // Returns events that are relevant to the authorized user, i.e. home timeline and notifications
  public class UserStream : StreamBase {
    
    public UserStream (string website, string client_id, string client_secret, string? access_token = null) {
      base (website, client_id, client_secret, access_token);
    }
    
    public UserStream.new_for_gompho_app (ValastodonApp app) {
      base (app.website, app.client_id, app.client_secret, app.access_token);
    }
    
    public bool continuous (owned StreamCallback cb) throws Error {
      
      proxy_call = proxy.new_call ();
      proxy_call.set_function(ENDPOINT_STREAMING_USER);
      
      try {
        return continuous_body ((owned) cb);
      } catch (Error e) {
        throw e;
      }
    }
  }
  
  // Returns all public statuses
  public class PublicStream : StreamBase {
    
    public PublicStream (string website, string client_id, string client_secret, string? access_token = null) {
      base (website, client_id, client_secret, access_token);
    }
    
    public PublicStream.new_for_gompho_app (ValastodonApp app) {
      base (app.website, app.client_id, app.client_secret, app.access_token);
    }
    
    public bool continuous (owned StreamCallback cb, bool local = false) throws Error {
      
      proxy_call = proxy.new_call ();
      proxy_call.set_function(ENDPOINT_STREAMING_PUBLIC + (local ? "/local" : ""));;
      
      try {
        return continuous_body ((owned) cb);
      } catch (Error e) {
        throw e;
      }
    }
  }
  
  // Returns all public statuses for a particular hashtag
  public class HashtagStream : StreamBase {
    
    public HashtagStream (string website, string client_id, string client_secret, string? access_token = null) {
      base (website, client_id, client_secret, access_token);
    }
    
    public HashtagStream.new_for_gompho_app (ValastodonApp app) {
      base (app.website, app.client_id, app.client_secret, app.access_token);
    }
    
    public bool continuous (owned StreamCallback cb, string tag, bool local = false) throws Error {
      
      proxy_call = proxy.new_call ();
      proxy_call.add_param (PARAM_TAG, tag);
      proxy_call.set_function(ENDPOINT_STREAMING_PUBLIC + (local ? "/local" : ""));;
      
      try {
        return continuous_body ((owned) cb);
      } catch (Error e) {
        throw e;
      }
    }
  }
  
  // Callback
  public delegate void StreamCallback (string event, Valastodon.Object object);
  
  // Base class
  public abstract class Object {}
}

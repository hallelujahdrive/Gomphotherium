using Json;
using Rest;

namespace Gomphotherium {
  
  public class GomphoStream : GLib.Object {

    // Property-backing fields
    private string _website;
    private string _client_id;
    private string _client_secret;
    private string _access_token;
    
    private Rest.Proxy proxy;

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
    private StringBuilder hashtag_string_builder = new StringBuilder ();
    private StringBuilder public_string_builder = new StringBuilder ();
    private StringBuilder user_string_builder = new StringBuilder ();
    
    private StreamCallback hashtag_stream_callback;
    private StreamCallback public_stream_callback;
    private StreamCallback user_stream_callback;
    
    private Error public_error;
    private Error hashtag_error;
    private Error user_error;
    
    public GomphoStream (string website, string client_id, string client_secret, string? access_token = null) {
      _website = website;
      _client_id = client_id;
      _client_secret = client_secret;
      
      proxy = new Rest.Proxy (_website, false);
      
      if (access_token != null){
        _access_token = access_token;
      }
    }
    
    public GomphoStream.from_gompho_app (GomphoAppBase app) {
      this (app.website, app.client_id, app.client_secret, app.access_token);
    }
    
    
    // Returns events that are relevant to the authorized user, i.e. user timeline and notifications
    public bool streaming_user (owned StreamCallback cb) throws Error {
      
      user_stream_callback = (owned) cb;
      
      var proxy_call = proxy.new_call ();
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_STREAMING_USER);
      proxy_call.set_method("GET");
      
      try {
        
        return proxy_call.continuous (user_continuous_proxy_callback, proxy_call);
        
      } catch (Error e) {
        throw e;
      }
    }
    
    // Returns all public statuses
    public bool streaming_public (owned StreamCallback cb, bool local = false) throws Error {
      
      public_stream_callback = (owned) cb;
      
      var proxy_call = proxy.new_call ();
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_STREAMING_PUBLIC + (local ? "/local" : ""));
      proxy_call.set_method("GET");
      
      try {
        
        return proxy_call.continuous (public_continuous_proxy_callback, proxy_call);
        
      } catch (Error e) {
        throw e;
      }
    }
    
    // Returns all public statuses for a particular hashtag (query param tag)
    public bool streaming_hashtag (owned StreamCallback cb, string tag, bool local = false) throws Error {
      
      hashtag_stream_callback = (owned) cb;
      
      var proxy_call = proxy.new_call ();
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.add_param (PARAM_TAG, tag);
      proxy_call.set_function(ENDPOINT_STREAMING_HASHTAG + (local ? "/local" : ""));
      proxy_call.set_method("GET");
      
      try {
        return proxy_call.continuous (hashtag_continuous_proxy_callback, proxy_call);
      } catch (Error e) {
        throw e;
      }
    }
    
    
    // ProxyCallContinuousCallback does not allow 'buf' is null.
    private void user_continuous_proxy_callback (ProxyCall call, string? buf, size_t len, Error? error, GLib.Object? weak_object) {
      if (error != null) {
        user_error = error;
        return;
      }
      
      if (buf != null) {
        string fragment = buf.substring(0, (int) len);
        user_string_builder.append (fragment);
        
        
        if (fragment.has_prefix (":thump")) { // ':thump' is a heartbeat
          user_string_builder.erase ();
        } else if (fragment.has_suffix ("\r\n") || fragment.has_suffix ("\n\n")) {
          //stdout.printf ("payload : %s\n", user_string_builder.str);
          string event_type;
          Gomphotherium.Object object;
          
          if (parse_payload (user_string_builder.str, out event_type, out object)) {
              user_stream_callback (event_type, object);
          }
          
          user_string_builder.erase ();
        }
      } else {
        stdout.printf ("buf : null");
      }
    }
    
    private void public_continuous_proxy_callback (ProxyCall call, string? buf, size_t len, Error? error, GLib.Object? weak_object) {
      if (error != null) {
        public_error = error;
        return;
      }
      
      if (buf != null) {
        string fragment = buf.substring(0, (int) len);
        public_string_builder.append (fragment);
        
        
        if (fragment.has_prefix (":thump")) { // ':thump' is a heaerbeat
          public_string_builder.erase ();
        } else if (fragment.has_suffix ("\r\n") || fragment.has_suffix ("\n\n")) {
          //stdout.printf ("payload : %s\n", public_string_builder.str);
          string event_type;
          Gomphotherium.Object object;
          
          if (parse_payload (public_string_builder.str, out event_type, out object)) {
              public_stream_callback (event_type, object);
          }
          
          public_string_builder.erase ();
        }
      } else {
        stdout.printf ("buf : null");
      }
    }
    
    private void hashtag_continuous_proxy_callback (ProxyCall call, string? buf, size_t len, Error? error, GLib.Object? weak_object) {
      if (error != null) {
        hashtag_error = error;
        return;
      }
      
      if (buf != null) {
        string fragment = buf.substring(0, (int) len);
        hashtag_string_builder.append (fragment);
        
        
        if (fragment.has_prefix (":thump")) { // ':thump' is a heartbeat
          hashtag_string_builder.erase ();
        } else if (fragment.has_suffix ("\r\n") || fragment.has_suffix ("\n\n")) {
          stdout.printf ("payload : %s\n", hashtag_string_builder.str);
          string event_type;
          Gomphotherium.Object object;
          
          if (parse_payload (hashtag_string_builder.str, out event_type, out object)) {
              hashtag_stream_callback (event_type, object);
          }
          
          hashtag_string_builder.erase ();
        }
      } else {
        stdout.printf ("buf : null");
      }
    }
    
    private bool parse_payload (string payload, out string event_type, out Gomphotherium.Object object) {
      
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
  
  // Callback
  public delegate void StreamCallback (string event, Gomphotherium.Object object);
  
  // Base class
  public abstract class Object {}
}

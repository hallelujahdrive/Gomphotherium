using Json;
using Rest;
using Soup;

namespace Gomphoterium {
  
  public class Application {
    // Property-backing fields
    private string _website;
    private string _client_id;
    private string _client_secret;
    private string _access_token;
    
    //private OAuthProxy api_proxy;
    private OAuth2Proxy api_proxy;
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
    
    // @website : Instance URL
    // @client_id : Client ID of your application
    // @client_secret : Client Secret of your cpplication
    public Application (string website, string client_id, string client_secret, string? access_token = null) {
      _website = website;
      _client_id = client_id;
      _client_secret = client_secret;
      
      //api_proxy = new OAuthProxy (_client_id, _client_secret, _website, false);
      api_proxy = new OAuth2Proxy (_client_id, "urn:ietf:wg:oauth:2.0:oob", _website, false);
      proxy = new Rest.Proxy (_website, false);
      
      if (access_token != null){
        _access_token = access_token;
      }
    }
    
    // Getting an access token
    public string oauth_token (string email, string password, string scope) throws Error {
      
      var session = new Soup.Session ();
      var message = new Soup.Message ("POST", _website + ENDPOINT_OAUTH_TOKEN);
    
      var buffer = Soup.MemoryUse.STATIC;
      string params = build_oauth_params (email, password, scope);
      
      message.set_request ("application/x-www-form-urlencoded", buffer, params.data);

      session.send_message (message);
      
      try {
        var json_obj = parse_json_data (message.response_body.data);
        
        return _access_token = json_obj.get_string_member ("access_token");
        
      } catch (Error e) {
        throw e;
      }
    }
    
    // Getting an access token asynchronously
    public async string oauth_token_async (string email, string password, string scope) throws Error {
      
      var session = new Soup.Session ();
      var message = new Soup.Message ("POST", _website + ENDPOINT_OAUTH_TOKEN);
    
      var buffer = Soup.MemoryUse.STATIC;
      string params = build_oauth_params (email, password, scope);
      
      message.set_request ("application/x-www-form-urlencoded", buffer, params.data);
      
      SourceFunc callback = oauth_token_async.callback;
      
      string access_token = "";
      
      ThreadFunc<void*> run = () => {
        var loop = new MainLoop ();
        session.queue_message (message, (sess, mess) => {
          try {
            var json_obj = parse_json_data (mess.response_body.data);
            
            access_token = json_obj.get_string_member ("access_token");
            
            loop.quit ();

          } catch (Error e) {
            throw e;
          }
        });
        loop.run ();
        Idle.add ((owned) callback);
        return null;
      };
      
      new Thread<void*> (null, run);
      
      yield;
      return access_token;
    }
    
    // Getting a current user
    public Account account_verify_credentials () throws Error {
      var proxy_call = proxy.new_call ();
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_ACCOUNT_VERIFY_CREDENTIALS);
      proxy_call.set_method("GET");
      try{
        proxy_call.run();
        var parser = new Parser();
        var data = proxy_call.get_payload();
        stdout.printf (data);
        parser.load_from_data(data);
        var json_obj = parser.get_root().get_object();
        
        return new Account (json_obj);
      }catch(Error error){
        throw error;
      }
    }
    
    // private methods
    private string build_oauth_params (string email, string password, string scope) {
      return PARAM_CLIENT_ID + "=" + _client_id + "&" + PARAM_CLIENT_SECRET + "=" + _client_secret + "&grant_type=password&" + PARAM_USERNAME + "=" + email + "&" + PARAM_PASSWORD + "=" + password + "&" + PARAM_SCOPE + "=" +scope;
    }
  }
}

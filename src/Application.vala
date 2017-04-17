using Rest;
using Soup;

namespace Gomphoterium {
  
  public class Application {
    // Property-backing fields
    private string _website;
    private string _client_id;
    private string _client_secret;
    
    private OAuthProxy _api_proxy;
    
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
    
    // @website : Instance URL
    // @client_id : Client ID of your application
    // @client_secret : Client Secret of your cpplication
    public Application (string website, string client_id, string client_secret) {
      _website = website;
      _client_id = client_id;
      _client_secret = client_secret;
      
      _api_proxy = new OAuthProxy (_website, _client_id, _client_secret, false);
    }
    
    public Account? account_verify_credentials () throw Error {
      var proxy_call = account.api_proxy.new_call();
      proxy_call.set_function(FUNCTION_ACCOUNT_VERIFY_CREDENTIALS);
      proxy_call.set_method("GET");
      try{
        proxy_call.run();
        //Parser parser = new Parser();
        parser.load_from_data(proxy_call.get_payload());
        //parser.load_from_data(proxy_call.get_payload());
        //Json.Node node = parser.get_root();
        //Json.Object object=node.get_object();
      }catch(Error error){
        throw error;
      }
    }
  }
}

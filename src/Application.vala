using Soup;

namespace Gomphoterium {
  
  public class Application {
    // Property-backing fields
    private string _website;
    private string _client_id;
    private string _client_secret;
    
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
    }

  }
}

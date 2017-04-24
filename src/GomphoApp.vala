using Json;
using Rest;
using Soup;

namespace Gomphotherium {
  
  public class GomphoApp : GomphoAppBase {
        
    // @website : Instance URL
    // @client_id : Client ID of your GomphoApp
    // @client_secret : Client Secret of your cpplication
    // @access_token : (optional) Your access token
    public GomphoApp (string website, string client_id, string client_secret, string? access_token = null) {
      base (website, client_id, client_secret, access_token);
    }
    
    // Getting an access token
    // @email : A E-mail address of your account
    // @password : Your password
    // @scope : This can be a space-separated list of the following items: "read", "write" and "follow"
    public string oauth_token (string email, string password, string scope) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_oauth_proxy_call (ref proxy_call, email, password, scope);
      
      try {
        proxy_call.run ();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return _access_token = json_obj.get_string_member ("access_token");

      } catch (Error e) {
        throw e;
      }
    }

    // Gettinh an account
    public Account get_account (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_account_proxy_call (ref proxy_call, id);
      
      try{
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload());
        return new Account (json_obj);
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Getting a current user
    public Account verify_credentials () throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_verify_credentials_proxy_call (ref proxy_call);
      
      try{
        
        proxy_call.run();

        var json_obj = parse_json_object (proxy_call.get_payload());
        return new Account (json_obj);
        
      }catch(Error error){
        throw error;
      }
    }
    
    // Getting an account's followers
    public List<Account> get_followers (int64 id, int64? max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_followers_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Getting an account's following
    public List<Account> get_following (int64 id, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_following_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Getting an account's statuses
    public List<Status> get_statuses (int64 id, bool only_media = false, bool exclude_replies = false, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_statuses_proxy_call (ref proxy_call, id, only_media, exclude_replies, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var data = proxy_call.get_payload();

        var json_array = parse_json_array (data);
        var list = new List<Status> ();
                
        json_array.foreach_element ((array, index, node) => {
          list.append (new Status (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Getting an account's relationships
    public List<Relationship> get_relationships (int64[] ids) throws Error {
      
      Error error = null;
      
      var session = new Soup.Session ();
      var message = relationships_message_new (ids);
      
      session.send_message (message);
      
      var data = message.response_body.data;
      var data_str = ((string) data).substring (0, data.length);
      
      if (!handle_error_from_message (message, out error)) {
        throw error;
      }  

      try {
        var json_array = parse_json_array (data_str);

        var list = new List<Relationship> ();
                
        json_array.foreach_element ((array, index, node) => {
          list.append (new Relationship (node.get_object ()));
        });

        return (owned) list;
      
      } catch (Error e) {
        throw e;
      }
    }
    
    // Searching for accounts
    public List<Account> search_accounts (string q, int limit = -1) throws Error{
      
      var proxy_call = proxy.new_call ();
      setup_search_accounts_proxy_call (ref proxy_call, q, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }      
    }
    
    // Fetching a user's blocks
    public List<Account> get_blocks (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_blocks_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }

    // Fetching a user's favourites
    public List<Status> get_favourites (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_favoutrites_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Status> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Status (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Fetching  a list of follow requests
    public List<Account> get_follow_requests (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_follow_requests_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }

    // Getting instance information
    public Instance get_instance () throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_instance_proxy_call (ref proxy_call);
      
      try{
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload());
        return new Instance (json_obj);
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Getting instance information asynchronously
    public async Instance get_instance_async () throws Error {
      
      Error error = null;      
      Instance instance = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_instance_proxy_call (ref proxy_call);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          instance = new Instance (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        get_instance_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return instance;
    }

    // Fetching a user's mutes
    public List<Account> get_mutes (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_mutes_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }

    // Fetching a user's notifications
    public List<Gomphotherium.Notification> get_notifications (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_notifications_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Gomphotherium.Notification> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Gomphotherium.Notification (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }

    // Getting a single notification
    public Gomphotherium.Notification get_notification (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_notification_proxy_call (ref proxy_call, id);
      
      try{
        
        proxy_call.run();

        var json_obj = parse_json_object (proxy_call.get_payload());
        return new Gomphotherium.Notification (json_obj);
        
      }catch(Error error){
        throw error;
      }
    }

    // Fetching a user's reports
    public List<Report> get_reports () throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_reports_proxy_call (ref proxy_call);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Report> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Report (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Searching for content
    public Results search (string q, bool resolve) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_search_proxy_call (ref proxy_call, q, resolve);
      
      try{
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload());
        return new Results (json_obj);
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Fetching a status
    public Status get_status (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_status_proxy_call (ref proxy_call, id);
      
      try{
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload());
        return new Status (json_obj);
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Getting status context
    public Context get_context (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_context_proxy_call (ref proxy_call, id);
      
      try{
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload());
        return new Context (json_obj);
        
      }catch(Error e){
        throw e;
      }
    }

    // Getting a card associated with a status
    public Card get_card (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_card_proxy_call (ref proxy_call, id);
      
      try{
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload());
        return new Card (json_obj);
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Getting who reblogged a status
    public List<Account> get_reblogged_by (int64 id, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_reblogged_by_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }

    // Getting who favourited a status
    public List<Account> get_favourited_by (int64 id, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_favourited_by_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }

    // Retrieving home timeline
    public List<Status> get_home_timeline (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_home_timeline_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Status> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Status (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Retrieving public timeline
    public List<Status> get_public_timeline (bool local = false, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_public_timeline_proxy_call (ref proxy_call, local, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Status> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Status (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Retrieving htag timeline
    public List<Status> get_tag_timeline (string hashtag, bool local = false, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_tag_timeline_proxy_call (ref proxy_call, hashtag, local, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Status> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Status (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
  }
}

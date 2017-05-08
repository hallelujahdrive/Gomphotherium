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

    // Getting an account
    // @id : The ID of the account
    public Account get_account (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_account_proxy_call (ref proxy_call, id);
      
      try {
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Account (json_obj);
        
      } catch(Error e){
        throw e;
      }
    }
    
    // Getting the current user
    public Account verify_credentials () throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_verify_credentials_proxy_call (ref proxy_call);
      
      try {
        
        proxy_call.run();

        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Account (json_obj);
        
      } catch(Error error){
        throw error;
      }
    }
    
    // Updating the current user
    // @display_name : (optional) The name to display in the user's profile
    // @note : (optional) A new biography for the user
    // @avatar : (optional) An image to display as the user's avatar
    // @header : (optional) An image to display as the user's header image
    public Account update_credentials (string? display_name = null, string? note = null, File? avatar = null, File? header = null) throws Error {
      
      Error error = null;
      
      var session = new Soup.Session ();
      var message = update_credentials_message_new (display_name, note, avatar, header);
      
      session.send_message (message);
      
      var data = message.response_body.data;
      var data_str = ((string) data).substring (0, data.length);
      
      if (!handle_error_from_message (message, out error)) {
        throw error;
      }  

      try {
        var json_obj = parse_json_object (data_str);

        return new Account (json_obj);
      
      } catch (Error e) {
        throw e;
      } 
    }
    
    // Getting an account's followers
    // @id : The ID of the account to get followers
    // @ranging_params : (optional)
    //  @max_id : Get a list of followers with ID less than or equal this value
    //  @since_id : Get a list of followers with ID greater than this value
    //  @limit : Maximum number of followers to get (Default 40, Max 80)
    // @next_params : (optional)
    // @prev_params : (optional)
    public List<Account> get_followers (int64 id, RangingParams? ranging_params = null, out RangingParams? next_params = null, out RangingParams? prev_params = null) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_followers_proxy_call (ref proxy_call, ranging_params);
      
      try {
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload ());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      } catch (Error e) {
        throw e;
      }
    }
    
    // Getting an account's following
    // @id : The ID of the account to get following
    // @max_id : (optional) Get a list of following with ID less than or equal this value
    // @since_id : (optional) Get a list of following with ID greater than this value
    // @limit : (optional) Maximum number of following to get (Default 40, Max 80)
    public List<Account> get_following (int64 id, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_following_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      
      try {
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload ());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      } catch (Error e) {
        throw e;
      }
    }
    
    // Getting an account's statuses
    // @id : The ID of the account to get statuses
    // @only_media : (optional) Only return statuses that have media attachments
    // @exclude_replices (optional) Skip statuses that reply to other statuses
    // @max_id : (optional) Get a list of statuses with ID less than or equal this value
    // @since_id : (optional) Get a list of statuses with ID greater than this value
    // @limit : (optional) Maximum number of statuses to get (Default 20, Max 40) 	
    public List<Status> get_statuses (int64 id, bool only_media = false, bool exclude_replies = false, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_statuses_proxy_call (ref proxy_call, id, only_media, exclude_replies, max_id, since_id, limit);
      
      try {
        
        proxy_call.run();

        var headers = proxy_call.get_response_headers ();
        string next;
        string prev;
        parse_links (headers.get ("Link"), out next, out prev);
        
        var json_array = parse_json_array (proxy_call.get_payload ());
        var list = new List<Status> ();
                
        json_array.foreach_element ((array, index, node) => {
          list.append (new Status (node.get_object ()));
        });
        
        return (owned) list;
        
      } catch (Error e) {
        throw e;
      }
    }
    
    // Following an account
    // @id : The ID of the account to follow
    public Relationship follow (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_follow_proxy_call (ref proxy_call, id);
      
      try {
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Relationship (json_obj);
        
      } catch (Error e) {
        throw e;
      }
    }
    
    // Unfollowing an account
    // @id : The ID of the account to unfollow
    public Relationship unfollow (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_unfollow_proxy_call (ref proxy_call, id);
      
      try {
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Relationship (json_obj);
        
      } catch(Error e){
        throw e;
      }
    }

    // Blocking an account
    // @id : The ID of the account to block
    public Relationship block (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_block_proxy_call (ref proxy_call, id);
      
      try {
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Relationship (json_obj);
        
      } catch (Error e) {
        throw e;
      }
    }
    
    // Unblocking an account
    // @id : The ID of the account to unblock
    public Relationship unblock (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_unblock_proxy_call (ref proxy_call, id);
      
      try {
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Relationship (json_obj);
        
      } catch(Error e){
        throw e;
      }
    }
    
    // Muting an account
    // @id : The ID of the account to mute
    public Relationship mute (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_mute_proxy_call (ref proxy_call, id);
      
      try {
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Relationship (json_obj);
        
      } catch (Error e) {
        throw e;
      }
    }
    
    // Unmuting an account
    // @id : The ID of the account to unmute
    public Relationship unmute (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_unmute_proxy_call (ref proxy_call, id);
      
      try {
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Relationship (json_obj);
        
      } catch (Error e) {
        throw e;
      }
    }

    // Getting an account's relationships
    // @ids : The IDs of accounts to get relationships
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
    
    // Getting an account's relationship
    // @id : The ID of the account to get relationship
    public Relationship get_relationship (int64 id) throws Error {
      
      try {
        var list = get_relationships ({id});
        return list.nth_data (0);
      } catch (Error e) {
        throw e;
      }
    }
    
    // Searching for accounts
    // @q : What to search for
    // @limit : (optional) Maximum number of matching accounts to return (default: 40)
    public List<Account> search_accounts (string q, int limit = -1) throws Error{
      
      var proxy_call = proxy.new_call ();
      setup_search_accounts_proxy_call (ref proxy_call, q, limit);
      
      try {
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload ());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      } catch (Error e) {
        throw e;
      }      
    }
    
    // Fetching a user's blocks
    // @max_id : (optional) Get a list of blocks with ID less than or equal this value
    // @since_id : (optional) Get a list of blocks with ID greater than this value
    // @limit : (optional) Maximum number of blocks to get (Default 40, Max 80) 	
    public List<Account> get_blocks (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_blocks_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try {
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload ());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      } catch (Error e) {
        throw e;
      }
    }

    // Fetching a user's favourites
    // @max_id : (optional) Get a list of favourites with ID less than or equal this value
    // @since_id : (optional) Get a list of favourites with ID greater than this value
    // @limit : (optional) Maximum number of favourites to get (Default 20, Max 40) 	
    public List<Status> get_favourites (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_favoutrites_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try {
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload ());
        var list = new List<Status> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Status (node.get_object ()));
        });
        
        return (owned) list;
        
      } catch (Error e) {
        throw e;
      }
    }
    
    // Fetching  a list of follow requests
    // @max_id : (optional) Get a list of follow requests with ID less than or equal this value
    // @since_id : (optional) Get a list of follow requests with ID greater than this value
    // @limit : (optional) Maximum number of follow requests to get (Default 40, Max 80) 	
    public List<Account> get_follow_requests (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_follow_requests_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try {
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload ());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      } catch(Error e){
        throw e;
      }
    }
    
    // Authorizing a follow request
    // @id : The ID of the account to authorize
    public void authorize_follow_request (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_authorize_follow_request_proxy_call (ref proxy_call, id);

      try {
        proxy_call.run();
      } catch (Error e) {
        throw e;
      }
    }

    // Rejecting a follow request
    // @id : The ID of the account to reject
    public void reject_follow_request (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_reject_follow_request_proxy_call (ref proxy_call, id);

      try {
        proxy_call.run();
      } catch(Error e){
        throw e;
      }
    }
    
    // Following a remote user
    // @uri : username@domain of the person you want to follow
    public Account remote_follow (string uri) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_remote_follow_proxy_call (ref proxy_call, uri);
      
      try {
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Account (json_obj);
        
      } catch(Error e){
        throw e;
      }
    }

    // Getting instance information
    public Instance get_instance () throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_instance_proxy_call (ref proxy_call);
      
      try {
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Instance (json_obj);
        
      } catch(Error e){
        throw e;
      }
    }
    
    // Uploading a media attachment
    // file : Media to be uploaded
    public Attachment upload_media (File file) throws Error {

      Error error = null;
      
      var session = new Soup.Session ();
      var message =upload_media_message_new (file);
      
      session.send_message (message);
      
      var data = message.response_body.data;
      var data_str = ((string) data).substring (0, data.length);
      
      if (!handle_error_from_message (message, out error)) {
        throw error;
      }  

      try {
        return new Attachment (parse_json_object (data_str));
      } catch (Error e) {
        throw e;
      }
    }

    // Fetching a user's mutes
    // @max_id : (optional) Get a list of mutes with ID less than or equal this value
    // @since_id : (optional) Get a list of mutes with ID greater than this value
    // @limit : (optional) Maximum number of mutes to get (Default 40, Max 80) 	
    public List<Account> get_mutes (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_mutes_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try {
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload ());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      } catch(Error e){
        throw e;
      }
    }

    // Fetching a user's notifications
    // @max_id : (optional) Get a list of notifications with ID less than or equal this value
    // @since_id : (optional) Get a list of notifications with ID greater than this value
    // @limit : (optional) Maximum number of notifications to get (Default 15, Max 30) 	
    public List<Gomphotherium.Notification> get_notifications (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_notifications_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try {
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload ());
        var list = new List<Gomphotherium.Notification> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Gomphotherium.Notification (node.get_object ()));
        });
        
        return (owned) list;
        
      } catch(Error e){
        throw e;
      }
    }

    // Getting a single notification
    // @id : The ID of the account to get notifications
    public Gomphotherium.Notification get_notification (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_notification_proxy_call (ref proxy_call, id);
      
      try {
        
        proxy_call.run();

        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Gomphotherium.Notification (json_obj);
        
      } catch(Error error){
        throw error;
      }
    }
    
    // Clearing notifications
    public void clear_notifications () throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_clear_notifications_proxy_call (ref proxy_call);
      
      try {
        proxy_call.run();
      } catch(Error error){
        throw error;
      }
    }

    // Fetching a user's reports
    public List<Report> get_reports () throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_reports_proxy_call (ref proxy_call);
      
      try {
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload ());
        var list = new List<Report> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Report (node.get_object ()));
        });
        
        return (owned) list;
        
      } catch(Error e){
        throw e;
      }
    }
    
    // Reporting a user
    // @account_id : The ID of the account to report
    // @status_ids : The IDs of statuses to report
    // @comment : A comment to associate with the report
    public Report report (int64 account_id, int64[] status_ids, string comment) {
      
      Error error = null;
      
      var session = new Soup.Session ();
      var message = report_message_new (account_id, status_ids, comment);
      
      session.send_message (message);
      
      var data = message.response_body.data;
      var data_str = ((string) data).substring (0, data.length);
      
      if (!handle_error_from_message (message, out error)) {
        throw error;
      }  

      try {
        return new Report (parse_json_object (data_str));
      } catch (Error e) {
        throw e;
      }      
    }
    
    // Searching for content
    // @q : The search query
    // @resolve : Whether to resolve non-local accounts
    public Results search (string q, bool resolve) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_search_proxy_call (ref proxy_call, q, resolve);
      
      try {
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Results (json_obj);
        
      } catch(Error e){
        throw e;
      }
    }
    
    // Fetching a status
    // @id : The ID of the status
    public Status get_status (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_status_proxy_call (ref proxy_call, id);
      
      try {
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Status (json_obj);
        
      } catch(Error e){
        throw e;
      }
    }
    
    // Getting status context
    // @id : The ID of the status
    public Context get_context (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_context_proxy_call (ref proxy_call, id);
      
      try {
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Context (json_obj);
        
      } catch(Error e){
        throw e;
      }
    }

    // Getting a card associated with a status
    // @id : The ID of the status
    public Card get_card (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_card_proxy_call (ref proxy_call, id);
      
      try {
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Card (json_obj);
        
      } catch(Error e){
        throw e;
      }
    }
    
    // Getting who reblogged a status
    // @max_id : (optional) Get a list of reblogged with ID less than or equal this value
    // @since_id : (optional) Get a list of reblogged with ID greater than this value
    // @limit : (optional) Maximum number of reblogged to get (Default 40, Max 80) 	
    public List<Account> get_reblogged_by (int64 id, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_reblogged_by_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      
      try {
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload ());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      } catch(Error e){
        throw e;
      }
    }

    // Getting who favourited a status
    // @max_id : (optional) Get a list of favourited with ID less than or equal this value
    // @since_id : (optional) Get a list of favourited with ID greater than this value
    // @limit : (optional) Maximum number of favourited to get (Default 40, Max 80) 	
    public List<Account> get_favourited_by (int64 id, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_favourited_by_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      
      try {
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload ());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      } catch(Error e){
        throw e;
      }
    }
    
    
    // Posting a new status
    // @status : The text of the status
    // @in_reply_to_id : (optional) local ID of the status you want to reply to
    // @media_ids : (optional) Array of media IDs to attach to the status (maximum 4)
    // @sensitive : (optional) Set this to mark the media of the status as NSFW
    // @spoiler_text : (optional)	Text to be shown as a warning before the actual content
    // @visibility : (optional)	Either "direct", "private", "unlisted" or "public"
    public Status post_status (string status, int64 in_reply_to_id = -1, int64[]? media_ids = null, bool sensitive = false, string? spoiler_text = null, string? visibility = null) throws Error {

      Error error = null;
      
      var session = new Soup.Session ();
      var message = post_status_message_new (status, in_reply_to_id, media_ids, sensitive, spoiler_text, visibility);
      
      session.send_message (message);
      
      var data = message.response_body.data;
      var data_str = ((string) data).substring (0, data.length);
      
      if (!handle_error_from_message (message, out error)) {
        throw error;
      }  

      try {
        return new Status (parse_json_object (data_str));
      } catch (Error e) {
        throw e;
      }         
    }
    
    // Reblogging a status
    // @id : The ID of status to reblog
    public Status reblog (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_reblog_proxy_call (ref proxy_call, id);
      
      try {
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Status (json_obj);
        
      } catch(Error e){
        throw e;
      }
    }
    
    // Unreblogging a status
    // @id : The ID of status to unreblog
    public Status unreblog (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_unreblog_proxy_call (ref proxy_call, id);
      
      try {
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Status (json_obj);
        
      } catch(Error e){
        throw e;
      }
    }
    
    // favouriting a status
    // @id : The ID of status to favourite
    public Status favourite (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_favourite_proxy_call (ref proxy_call, id);
      
      try {
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Status (json_obj);
        
      } catch(Error e){
        throw e;
      }
    }
    
    // unfavouriting a status
    // @id : The ID of status to unfavourite
    public Status unfavourite (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_unfavourite_proxy_call (ref proxy_call, id);
      
      try {
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return new Status (json_obj);
        
      } catch(Error e){
        throw e;
      }
    }

    // Retrieving home timeline
    // @max_id : (optional) Get a list of followers with ID less than or equal this value
    // @since_id : (optional) Get a list of followers with ID greater than this value
    // @limit : (optional) Maximum number of followers to get (Default 40, Max 80) 	
    public List<Status> get_home_timeline (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_home_timeline_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try {
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload ());
        var list = new List<Status> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Status (node.get_object ()));
        });
        
        return (owned) list;
        
      } catch(Error e){
        throw e;
      }
    }
    
    // Retrieving public timeline
    // @local : (optional) Only return statuses originating from this instance
    // @max_id : (optional) Get a list of followers with ID less than or equal this value
    // @since_id : (optional) Get a list of followers with ID greater than this value
    // @limit : (optional) Maximum number of followers to get (Default 40, Max 80) 	
    public List<Status> get_public_timeline (bool local = true, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_public_timeline_proxy_call (ref proxy_call, local, max_id, since_id, limit);
      
      try {
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload ());
        var list = new List<Status> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Status (node.get_object ()));
        });
        
        return (owned) list;
        
      } catch(Error e){
        throw e;
      }
    }
    
    // Retrieving htag timeline
    // @hashtag : The hashtag to search
    // @local : (optional) Only return statuses originating from this instance
    // @max_id : (optional) Get a list of followers with ID less than or equal this value
    // @since_id : (optional) Get a list of followers with ID greater than this value
    // @limit : (optional) Maximum number of followers to get (Default 40, Max 80) 	
    public List<Status> get_tag_timeline (string hashtag, bool local = true, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_tag_timeline_proxy_call (ref proxy_call, hashtag, local, max_id, since_id, limit);
      
      try {
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload ());
        var list = new List<Status> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Status (node.get_object ()));
        });
        
        return (owned) list;
        
      } catch(Error e){
        throw e;
      }
    }
  }
}

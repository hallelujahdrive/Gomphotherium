using Json;
using Rest;
using Soup;

namespace Gomphotherium {
  
  public class GomphoAppBase : GLib.Object {
    
    // Property-backing fields
    protected string _website;
    protected string _client_id;
    protected string _client_secret;
    protected string _access_token;
    
    protected Rest.Proxy proxy;

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
    // @client_id : Client ID of your GomphoApp
    // @client_secret : Client Secret of your cpplication
    // @access_token : (optional) Your access token
    public GomphoAppBase (string website, string client_id, string client_secret, string? access_token) {
      _website = website;
      _client_id = client_id;
      _client_secret = client_secret;
      
      proxy = new Rest.Proxy (_website, false);
      
      if (access_token != null){
        _access_token = access_token;
      }
    }

    // Set proxy params to oauth
    protected void setup_oauth_proxy_call (ref ProxyCall proxy_call, string email, string password, string scope) {
      
      proxy_call.add_params (PARAM_CLIENT_ID, _client_id, PARAM_CLIENT_SECRET, _client_secret, PARAM_GRANT_TYPE, "password", PARAM_USERNAME, email, PARAM_PASSWORD, password, PARAM_SCOPE, scope);
      proxy_call.set_function (ENDPOINT_OAUTH_TOKEN);
      proxy_call.set_method ("POST");
    }
    
    // Set proxy params to get an account
    protected void setup_get_account_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_ACCOUNTS.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get followers
    protected void setup_get_followers_proxy_call (ref ProxyCall proxy_call, int64 id, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_ACCOUNTS_FOLLOWERS.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get following
    protected void setup_get_following_proxy_call (ref ProxyCall proxy_call, int64 id, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_ACCOUNTS_FOLLOWING.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get statuses
    protected void setup_get_statuses_proxy_call (ref ProxyCall proxy_call, int64 id, bool only_media, bool exclude_replies, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      
      if (only_media) {
        proxy_call.add_param (PARAM_ONLY_MEDIA, only_media.to_string ());
      }
      if (exclude_replies) {
        proxy_call.add_param (PARAM_EXCLUDE_REPLIES, exclude_replies.to_string ());
      }
      
      proxy_call.set_function(ENDPOINT_ACCOUNTS_STATUSES.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to follow
    protected void setup_follow_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);     
      proxy_call.set_function (ENDPOINT_ACCOUNTS_FOLLOW.printf (id));
      proxy_call.set_method ("POST");
      
    }
    
    // Set proxy params to unfollow
    protected void setup_unfollow_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);     
      proxy_call.set_function (ENDPOINT_ACCOUNTS_UNFOLLOW.printf (id));
      proxy_call.set_method ("POST");
      
    }    
    
    // Set proxy params to block
    protected void setup_block_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);     
      proxy_call.set_function (ENDPOINT_ACCOUNTS_BLOCK.printf (id));
      proxy_call.set_method ("POST");
      
    }
    
    // Set proxy params to unblock
    protected void setup_unblock_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);     
      proxy_call.set_function (ENDPOINT_ACCOUNTS_UNBLOCK.printf (id));
      proxy_call.set_method ("POST");
      
    }
    
    // Set proxy params to mute
    protected void setup_mute_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);     
      proxy_call.set_function (ENDPOINT_ACCOUNTS_MUTE.printf (id));
      proxy_call.set_method ("POST");
      
    }
    
    // Set proxy params to unmute
    protected void setup_unmute_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);     
      proxy_call.set_function (ENDPOINT_ACCOUNTS_UNMUTE.printf (id));
      proxy_call.set_method ("POST");
      
    }
    
    // Set proxy params to search accounts
    protected void setup_search_accounts_proxy_call (ref ProxyCall proxy_call, string q, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.add_param (PARAM_Q, q);
      
      if (limit >= 0) {
        proxy_call.add_param (PARAM_LIMIT, limit.to_string ());
      }
      
      proxy_call.set_function(ENDPOINT_ACCOUNTS_SEARCH);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to fetch blocks
    protected void setup_get_blocks_proxy_call (ref ProxyCall proxy_call, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_BLOCKS);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to fetch favoutites
    protected void setup_get_favoutrites_proxy_call (ref ProxyCall proxy_call, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_FAVOURITES);
      proxy_call.set_method("GET");
    
    }

    // Set proxy params to fetch follow requests
    protected void setup_get_follow_requests_proxy_call (ref ProxyCall proxy_call, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_FOLLOW_REQUESTS);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to authorize follow requests
    protected void setup_authorize_follow_requests_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_FOLLOW_REQUESTS_AUTHORIZE.printf (id));
      proxy_call.set_method("POST");
      
    }

    // Set proxy params to reject follow requests
    protected void setup_reject_follow_requests_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_FOLLOW_REQUESTS_REJECT.printf (id));
      proxy_call.set_method("POST");
      
    }
    
    // Set proxy params to follow a remote user
    protected void setup_remote_follow_proxy_call (ref ProxyCall proxy_call, string uri) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.add_param (PARAM_URI, uri);
      proxy_call.set_function(ENDPOINT_FOLLOWS);
      proxy_call.set_method("POST");
    
    }
    
    
    // Set proxy params to verify credentials
    protected void setup_verify_credentials_proxy_call (ref ProxyCall proxy_call) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_ACCOUNTS_VERIFY_CREDENTIALS);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get instance information
    protected void setup_get_instance_proxy_call (ref ProxyCall proxy_call) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_INSTANCE);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy parasm to upload media
    protected void setup_upload_media_proxy_call (ref ProxyCall proxy_call, File file) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      // 保留
      // proxy_call.add_parama (PARAM_FILE, file);
      proxy_call.set_function(ENDPOINT_MEDIA);
      proxy_call.set_method("POST");
      
    }
    
    // Set proxy params to fetch mutes
    protected void setup_get_mutes_proxy_call (ref ProxyCall proxy_call, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_MUTES);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to fetch notifications
    protected void setup_get_notifications_proxy_call (ref ProxyCall proxy_call, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_NOTIFICATIONS);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get a single notification
    protected void setup_get_notification_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_NOTIFICATION.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to clear notifications
    protected void setup_clear_notifications_proxy_call (ref ProxyCall proxy_call) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_NOTIFICATIONS_CLIEAR);
      proxy_call.set_method("POST");
    
    }
    
    // Set proxy params to fetch reports
    protected void setup_get_reports_proxy_call (ref ProxyCall proxy_call) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_REPORTS);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to search for content
    protected void setup_search_proxy_call (ref ProxyCall proxy_call, string q, bool resolve) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_SEARCH);
      proxy_call.add_param (PARAM_Q, q);
      proxy_call.add_param (PARAM_RESOLVE, resolve.to_string ());
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to fetch a status
    protected void setup_get_status_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_STATUSES_ID.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get status context
    protected void setup_get_context_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_STATUSES_CONTEXT.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get a card associated with status
    protected void setup_get_card_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_STATUSES_CARD.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get who reblogged a status
    protected void setup_get_reblogged_by_proxy_call (ref ProxyCall proxy_call, int64 id, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_STATUSES_REBLOGGED_BY.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get who favourited a status
    protected void setup_get_favourited_by_proxy_call (ref ProxyCall proxy_call, int64 id, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_STATUSES_FAVOURITED_BY.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get home timeline
    protected void setup_get_home_timeline_proxy_call (ref ProxyCall proxy_call, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_TIMELINES_HOME);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get public timeline
    protected void setup_get_public_timeline_proxy_call (ref ProxyCall proxy_call, bool local, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
     
      if (local) {
        proxy_call.add_param (PARAM_LOCAL, "");
      }
      
      proxy_call.set_function(ENDPOINT_TIMELINES_PUBLIC);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get tag timeline
    protected void setup_get_tag_timeline_proxy_call (ref ProxyCall proxy_call,string hashtag, bool local, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      if (local) {
        proxy_call.add_param (PARAM_LOCAL, "");
      }
      
      proxy_call.set_function(ENDPOINT_TIMELINES_TAG.printf (hashtag));
      proxy_call.set_method("GET");
    
    }
    
    // Generate a soup message to get relatiopnships
    protected Soup.Message relationships_message_new (int64[] ids) {
      
      var message = new Soup.Message ("GET", _website + ENDPOINT_ACCOUNTS_RELATIONSHIPS);
      var sb = new StringBuilder ();
      
      int i = 0;
      foreach (int64 id in ids) {
        sb.append (PARAM_ID);
        sb.append ("[]=");
        sb.append (id.to_string ());
        if (++i < ids.length) {
          sb.append ("&");
        }
      }
      
      message.request_headers.append ("Authorization"," Bearer " + _access_token);
      message.set_request ("application/x-www-form-urlencoded", Soup.MemoryUse.COPY, sb.str.data);
      
      return message;
    
    }
    
    // Generate a soup message to report a user
    protected Soup.Message report_message_new (int64 account_id, int64[] status_ids, string comment) throws Erro {
      
      var message = new Soup.Message ("POST", _website + ENDPOINT_REPORTS);
      var sb = new StringBuilder ();
      
      sb.append (PARAM_ACCOUNT_ID);
      sb.append ("=");
      sb.append (account_id.to_string ());
      sb.append ("&");
      foreach (int64 id in ids) {
        sb.append (PARAM_STATUS_IDS);
        sb.append ("[]=");
        sb.append (id.to_string ());
        sb.append ("&");
      }
      sb.append (PARAM_COMMENT);
      sb.append ("=");
      sb.append (comment);
      
      message.request_headers.append ("Authorization"," Bearer " + _access_token);
      message.set_request ("application/x-www-form-urlencoded", Soup.MemoryUse.COPY, sb.str.data);
      
      return message;
    }
    
    protected void set_ids_and_limit_to_proxy_call (ref ProxyCall proxy_call, int64 max_id, int64 since_id, int limit) {
      
      if (max_id >= 0) {
        proxy_call.add_param (PARAM_MAX_ID, max_id.to_string ());
      }
      if (since_id >= 0) {
        proxy_call.add_param (PARAM_SINCE_ID, since_id.to_string ());
      }
      if (limit >= 0) {
        proxy_call.add_param (PARAM_LIMIT, limit.to_string ());
      }
      
    }
  }
}


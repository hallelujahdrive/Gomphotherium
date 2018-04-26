using Json;
using Rest;
using Soup;

namespace Valastodon {
  
  public class AsyncValastodonApp : ValastodonAppBase {
        
    // @website : Instance URL
    // @client_id : Client ID of your ValastodonApp
    // @client_secret : Client Secret of your cpplication
    // @access_token : (optional) Your access token
    public AsyncValastodonApp (string website, string client_id, string client_secret, string? access_token = null) {
      base (website, client_id, client_secret, access_token);
    }
    
    // Getting an access token asynchronously
    // @email : A E-mail address of your account
    // @password : Your password
    // @scope : This can be a space-separated list of the following items: "read", "write" and "follow"
    // @cancellable : It can be used to cancel the call
    public async string oauth_token_async (string email, string password, string scope, Cancellable? cancellable) throws Error {
      
      Error error = null;
      
      var proxy_call = proxy.new_call ();
      setup_oauth_proxy_call (ref proxy_call, email, password, scope);
      
      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
          
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload ());
          _access_token = json_obj.get_string_member ("access_token");
          
        } catch (Error e) {
          error = e;
        }
        
        oauth_token_async.callback ();
        
      });
      
      yield;
      
      if (error != null) {
        throw error;
      }
      
      return _access_token;
    }
    
    // Getting an account asynchronously
    // @id : The ID of the account
    // @cancellable : It can be used to cancel the callcall
    public async Account get_account_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;      
      Account account = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_account_proxy_call (ref proxy_call, id);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          account = new Account (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        get_account_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return account;
    }    
    
    // Getting the current user asynchronously
    // @cancellable : It can be used to cancel the call
    public async Account verify_credentials_async (Cancellable? cancellable) throws Error {
      
      Error error = null;
      Account account = null;
      
      var proxy_call = proxy.new_call ();
      setup_verify_credentials_proxy_call (ref proxy_call);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          account = new Account (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        verify_credentials_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return account;
    }
    
    // Updating the current user asynchronously
    // @display_name : The name to display in the user's profile
    // @note : A new biography for the user
    // @avatar : An image to display as the user's avatar
    // @header : An image to display as the user's header image
    // @cancellable : It can be used to cancel the call
    public async Account update_credentials_async (string? display_name, string? note, File? avatar, File? header, Cancellable? cancellable) throws Error {
      
      Error error = null;
      Account account = null;
      
      var session = new Soup.Session ();
      var message = update_credentials_message_new (display_name, note, avatar, header);
      
      SourceFunc callback = update_credentials_async.callback;
      
      ThreadFunc<void*> run = () => {
        var loop = new MainLoop ();
        session.queue_message (message, (sess, mess) => {
              
          if (!handle_error_from_message (mess, out error)) {
            loop.quit();
          }
          
          var data = message.response_body.data;
          var data_str = ((string) data).substring (0, data.length);

          try {
            var json_obj = parse_json_object (data_str);
            account = new Account (json_obj);
          } catch (Error e) {
            error = e;
          }
          
          loop.quit ();
        });
        loop.run ();
        Idle.add ((owned) callback);
        
        return null;
      };
      
      new Thread<void*> (null, run);
      
      yield;
      
      if (error != null) {
        throw error;
      }
      
      return account;
    }
    
    // Getting an account's followers asynchronously
    // @id : The ID of the account to get followers
    // @ranging_params : Parameters to select ranges of followers
    // @next_params : Parameters to select next ranges of followers
    // @prev_params : Parameters to select prev ranges of followers
    // @cancellable : It can be used to cancel the call
    public async List<Account> get_followers_async (int64 id, RangingParams? ranging_params, out RangingParams next_params, out RangingParams prev_params, Cancellable? cancellable) throws Error {
      
      next_params = null;
      prev_params = null;
      
      Error error = null;
      var list = new List<Account> ();
      RangingParams _next_params = null;
      RangingParams _prev_params = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_followers_proxy_call (ref proxy_call, id, ranging_params);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);

          var headers = proxy_call.get_response_headers ();
          parse_links (headers.get ("Link"), out _next_params, out _prev_params);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Account (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_followers_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      if (_next_params != null) {
        next_params = _next_params;
      }
      if (_prev_params != null) {
        prev_params = _prev_params;
      }
      
      return (owned) list;
    }
    
    // Getting an account's following asynchronously
    // @id : The ID of the account to get following
    // @ranging_params : Parameters to select ranges of following
    // @next_params : Parameters to select next ranges of folloeing
    // @prev_params : Parameters to select prev ranges of following
    // @cancellable : It can be used to cancel the call
    public async List<Account> get_following_async (int64 id, RangingParams? ranging_params, out RangingParams next_params, out RangingParams prev_params, Cancellable? cancellable) throws Error {
      
      next_params = null;
      prev_params = null;
      
      Error error = null;
      var list = new List<Account> ();
      RangingParams _next_params = null;
      RangingParams _prev_params = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_following_proxy_call (ref proxy_call, id, ranging_params);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);

          var headers = proxy_call.get_response_headers ();
          parse_links (headers.get ("Link"), out _next_params, out _prev_params);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Account (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_following_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      if (_next_params != null) {
        next_params = _next_params;
      }
      if (_prev_params != null) {
        prev_params = _prev_params;
      }
      
      return (owned) list;
    }
    
    // Getting an account's statuses asynchronously
    // @id : The ID of the account to get statuses
    // @only_media : Only return statuses that have media attachments
    // @exclude_replices Skip statuses that reply to other statuses
    // @ranging_params : Parameters to select ranges of statuses
    // @next_params : Parameters to select next ranges of statuses
    // @prev_params : Parameters to select prev ranges of statuses
    // @cancellable : It can be used to cancel the call
    public async List<Status> get_statuses_async (int64 id, bool only_media = false, bool exclude_replies = false, RangingParams? ranging_params, out RangingParams next_params, out RangingParams prev_params, Cancellable? cancellable) throws Error {
      
      next_params = null;
      prev_params = null;
      
      Error error = null;
      var list = new List<Status> ();
      RangingParams _next_params = null;
      RangingParams _prev_params = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_statuses_proxy_call (ref proxy_call, id, only_media, exclude_replies, ranging_params);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);

          var headers = proxy_call.get_response_headers ();
          parse_links (headers.get ("Link"), out _next_params, out _prev_params);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Status (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_statuses_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }
    
    // Following an account asynchronously
    // @id : The ID of the account to follow
    // @cancellable : It can be used to cancel the call
    public async Relationship follow_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;
      Relationship relationship = null;
      
      var proxy_call = proxy.new_call ();
      setup_follow_proxy_call (ref proxy_call, id);
      
      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          relationship = new Relationship (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        follow_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return relationship;
    }
    
    // Unfollowing an account asynchronously
    // @id : The ID of the account to unfollow
    // @cancellable : It can be used to cancel the call
    public async Relationship unfollow_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;
      Relationship relationship = null;
      
      var proxy_call = proxy.new_call ();
      setup_unfollow_proxy_call (ref proxy_call, id);
      
      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          relationship = new Relationship (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        unfollow_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return relationship;
    }
    
    // Blocking an account asynchronously
    // @id : The ID of the account to block
    // @cancellable : It can be used to cancel the call
    public async Relationship block_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;
      Relationship relationship = null;
      
      var proxy_call = proxy.new_call ();
      setup_block_proxy_call (ref proxy_call, id);
      
      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          relationship = new Relationship (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        block_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return relationship;
    }    

    // Unblocking an account asynchronously
    // @id : The ID of the account to unblock
    // @cancellable : It can be used to cancel the call
    public async Relationship unblock_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;
     Relationship relationship = null;
      
      var proxy_call = proxy.new_call ();
      setup_unblock_proxy_call (ref proxy_call, id);
      
      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          relationship = new Relationship (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        unblock_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return relationship;
    }
    
    // Muting an account asynchronously
    // @id : The ID of the account to mute
    // @cancellable : It can be used to cancel the call
    public async Relationship mute_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;
     Relationship relationship = null;
      
      var proxy_call = proxy.new_call ();
      setup_mute_proxy_call (ref proxy_call, id);
      
      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          relationship = new Relationship (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        mute_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return relationship;
    }

    // Unmuting an account asynchronously
    // @id : The ID of the account to unmute
    // @cancellable : It can be used to cancel the call
    public async Relationship unmute_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;
      Relationship relationship = null;
      
      var proxy_call = proxy.new_call ();
      setup_unmute_proxy_call (ref proxy_call, id);
      
      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          relationship = new Relationship (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        unmute_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return relationship;
    }

    // Getting an account's relationships asynchronously
    // @ids : The IDs of accounts to get relationships
    // @cancellable : It can be used to cancel the call
    public async List<Relationship> get_relationships_async (int64[] ids, Cancellable? cancellable) throws Error {
      
      Error error = null;
      var list = new List<Relationship> ();
      
      var session = new Soup.Session ();
      var message = relationships_message_new (ids);
      
      SourceFunc callback = get_relationships_async.callback;
      
      ThreadFunc<void*> run = () => {
        var loop = new MainLoop ();
        session.queue_message (message, (sess, mess) => {
              
          if (!handle_error_from_message (mess, out error)) {
            loop.quit();
          }
          
          var data = message.response_body.data;
          var data_str = ((string) data).substring (0, data.length);

          try {
            var json_array = parse_json_array (data_str);
                    
            json_array.foreach_element ((array, index, node) => {
              list.append (new Relationship (node.get_object ()));
            });
          } catch (Error e) {
            error = e;
          }
          
          loop.quit ();
        });
        loop.run ();
        Idle.add ((owned) callback);
        
        return null;
      };
      
      new Thread<void*> (null, run);
      
      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }
    
    // Getting an account's relationship asynchronously
    // @id : The ID of the account to get relationship
    // @cancellable : It can be used to cancel the call
    public async Relationship get_relationship_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;
        
      Relationship relationship = null;
      
      get_relationships_async.begin ({id}, cancellable, (obj, res) => {
        try {
          relationship = get_relationships_async.end (res).nth_data (0);
        } catch (Error e) {
          error = e;
        }
      });
      
      if (error != null) {
        throw error;
      }
      
      return relationship;
    }

    // Searching for accounts asynchronously
    // @q : What to search for
    // @limit : Maximum number of matching accounts to return (default: 40)
    // @cancellable : It can be used to cancel the call
    public async List<Account> search_accounts_async (string q, int limit, Cancellable? cancellable) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_search_accounts_proxy_call(ref proxy_call, q, limit);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Account (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        search_accounts_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }
    
    // Fetching a user's blocks asynchronously
    // @ranging_params : Parameters to select ranges of blocks
    // @next_params : Parameters to select next ranges of blocks
    // @prev_params : Parameters to select prev ranges of blocks
    // @cancellable : It can be used to cancel the call
    public async List<Account> get_blocks_async (RangingParams? ranging_params, out RangingParams next_params, out RangingParams prev_params, Cancellable? cancellable) throws Error {
      
      next_params = null;
      prev_params = null;
      
      Error error = null;
      var list = new List<Account> ();
      RangingParams _next_params = null;
      RangingParams _prev_params = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_blocks_proxy_call (ref proxy_call, ranging_params);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);

          var headers = proxy_call.get_response_headers ();
          parse_links (headers.get ("Link"), out _next_params, out _prev_params);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Account (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_blocks_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      if (_next_params != null) {
        next_params = _next_params;
      }
      if (_prev_params != null) {
        prev_params = _prev_params;
      }
      
      return (owned) list;
    }
    
    // Fetching a user's favourites asynchronously
    // @ranging_params : Parameters to select ranges of favourites
    // @next_params : Parameters to select next ranges of favourites
    // @prev_params : Parameters to select prev ranges of favourites
    // @cancellable : It can be used to cancel the call
    public async List<Status> get_favourites_async (RangingParams? ranging_params, out RangingParams next_params, out RangingParams prev_params, Cancellable? cancellable) throws Error {
      
      next_params = null;
      prev_params = null;
      
      Error error = null;
      var list = new List<Status> ();
      RangingParams _next_params = null;
      RangingParams _prev_params = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_favoutrites_proxy_call (ref proxy_call, ranging_params);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);

          var headers = proxy_call.get_response_headers ();
          parse_links (headers.get ("Link"), out _next_params, out _prev_params);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Status (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_favourites_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      if (_next_params != null) {
        next_params = _next_params;
      }
      if (_prev_params != null) {
        prev_params = _prev_params;
      }
      
      return (owned) list;
    }
    
    // Fetching  a list of follow requests asynchronously
    // @ranging_params : Parameters to select ranges of follow requests
    // @next_params : Parameters to select next ranges of follow requests
    // @prev_params : Parameters to select prev ranges of follow requests
    // @cancellable : It can be used to cancel the call
    public async List<Account> get_follow_requests_async (RangingParams? ranging_params, out RangingParams next_params, out RangingParams prev_params, Cancellable? cancellable) throws Error {
      
      next_params = null;
      prev_params = null;
      
      Error error = null;
      var list = new List<Account> ();
      RangingParams _next_params = null;
      RangingParams _prev_params = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_follow_requests_proxy_call (ref proxy_call, ranging_params);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);

          var headers = proxy_call.get_response_headers ();
          parse_links (headers.get ("Link"), out _next_params, out _prev_params);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Account (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_follow_requests_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }
    
    // Authorizing a follow request asynchronously
    // @id : The ID of the account to authorize
    // @cancellable : It can be used to cancel the call
    public async void authorize_follow_request_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;
      
      var proxy_call = proxy.new_call ();
      setup_authorize_follow_request_proxy_call (ref proxy_call, id);
      
      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
          proxy_call.invoke_async.end (res);
        } catch (Error e) {
          error = e;
        }
        
        authorize_follow_request_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
    }

    // Rejecting a follow request asynchronously
    // @id : The ID of the account to reject
    // @cancellable : It can be used to cancel the call
    public async void reject_follow_request_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;
      
      var proxy_call = proxy.new_call ();
      setup_reject_follow_request_proxy_call (ref proxy_call, id);
      
      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
          proxy_call.invoke_async.end (res);          
        } catch (Error e) {
          error = e;
        }
        
        reject_follow_request_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
    }

    // Following a remote user asynchronously
    // @uri : username@domain of the person you want to follow
    // @cancellable : It can be used to cancel the call
    public async Account remote_follow_async (string uri, Cancellable? cancellable) throws Error {
      
      Error error = null;
      Account account = null;
      
      var proxy_call = proxy.new_call ();
      setup_remote_follow_proxy_call (ref proxy_call, uri);
      
      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          account = new Account (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        remote_follow_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return account;
    }
 
    // Getting instance information asynchronously
    // @cancellable : It can be used to cancel the call
    public async Instance get_instance_async (Cancellable? cancellable) throws Error {
      
      Error error = null;      
      Instance instance = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_instance_proxy_call (ref proxy_call);
      
      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
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
    
    // Uploading a media attachment asynchronously
    // file : Media to be uploaded
    // @cancellable : It can be used to cancel the call
    public async Attachment upload_media_async (File file, Cancellable? cancellable) throws Error {
      
      Error error = null;
      Attachment attachment = null;
      
      var session = new Soup.Session ();
      var message = upload_media_message_new (file);
      
      SourceFunc callback = upload_media_async.callback;
      
      ThreadFunc<void*> run = () => {
        var loop = new MainLoop ();
        session.queue_message (message, (sess, mess) => {
              
          if (!handle_error_from_message (mess, out error)) {
            loop.quit();
          }
          
          var data = message.response_body.data;
          var data_str = ((string) data).substring (0, data.length);

          try {
            var json_obj = parse_json_object (data_str);
            attachment = new Attachment(json_obj);
          } catch (Error e) {
            error = e;
          }
          
          loop.quit ();
        });
        loop.run ();
        Idle.add ((owned) callback);
        
        return null;
      };
      
      new Thread<void*> (null, run);
      
      yield;
      
      if (error != null) {
        throw error;
      }
      
      return attachment;
    }

    // Fetching a user's mutes asynchronously
    // @ranging_params : Parameters to select ranges of mutes
    // @next_params : Parameters to select next ranges of mutes
    // @prev_params : Parameters to select prev ranges of mutes
    // @cancellable : It can be used to cancel the call
    public async List<Account> get_mutes_async (RangingParams? ranging_params, out RangingParams next_params, out RangingParams prev_params, Cancellable? cancellable) throws Error {
      
      next_params = null;
      prev_params = null;
      
      Error error = null;
      var list = new List<Account> ();
      RangingParams _next_params = null;
      RangingParams _prev_params = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_mutes_proxy_call (ref proxy_call, ranging_params);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);

          var headers = proxy_call.get_response_headers ();
          parse_links (headers.get ("Link"), out _next_params, out _prev_params);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Account (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_mutes_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      if (_next_params != null) {
        next_params = _next_params;
      }
      if (_prev_params != null) {
        prev_params = _prev_params;
      }
      
      return (owned) list;
    }
    
    // Fetching a user's notifications asynchronously
    // @ranging_params : Parameters to select ranges of notifications
    // @next_params : Parameters to select next ranges of notifications
    // @prev_params : Parameters to select prev ranges of notifications
    // @cancellable : It can be used to cancel the call
    public async List<Valastodon.Notification> get_notifications_async (RangingParams? ranging_params, out RangingParams next_params, out RangingParams prev_params, Cancellable? cancellable) throws Error {
      
      next_params = null;
      prev_params = null;
      
      Error error = null;
      var list = new List<Valastodon.Notification> ();
      RangingParams _next_params = null;
      RangingParams _prev_params = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_notifications_proxy_call (ref proxy_call, ranging_params);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);

          var headers = proxy_call.get_response_headers ();
          parse_links (headers.get ("Link"), out _next_params, out _prev_params);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Valastodon.Notification (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_notifications_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      if (_next_params != null) {
        next_params = _next_params;
      }
      if (_prev_params != null) {
        prev_params = _prev_params;
      }
      
      return (owned) list;
    }
    
    // Getting a single notification asynchronously
    // @id : The ID of the account to get notifications
    // @cancellable : It can be used to cancel the call
    public async Valastodon.Notification get_notification_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;
      Valastodon.Notification notification = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_notification_proxy_call (ref proxy_call, id);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          notification = new Valastodon.Notification (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        get_notification_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return notification;
    }
    
    // Clearing notifications
    // @cancellable : It can be used to cancel the call
    public async void clear_notifications_async (Cancellable? cancellable) throws Error {
      
      Error error = null;
      
      var proxy_call = proxy.new_call ();
      setup_clear_notifications_proxy_call (ref proxy_call);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
          proxy_call.invoke_async.end (res);
        } catch (Error e) {
          error = e;
        }
        
        clear_notifications_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
    }
    
    // Fetching a user's reports asynchronously
    // @cancellable : It can be used to cancel the call
    public async List<Report> get_reports_async (Cancellable? cancellable) throws Error {
      
      Error error = null;
      var list = new List<Report> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_reports_proxy_call (ref proxy_call);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Report (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_reports_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }

    // Reporting a user asynchronously
    // @account_id : The ID of the account to report
    // @status_ids : The IDs of statuses to report
    // @comment : A comment to associate with the report
    // @cancellable : It can be used to cancel the call
    public async Report report_async (int64 account_id, int64[] status_ids, string comment, Cancellable? cancellable) throws Error {
      
      Error error = null;
      Report report = null;
      
      var session = new Soup.Session ();
      var message = report_message_new (account_id, status_ids, comment);
      
      SourceFunc callback = report_async.callback;
      
      ThreadFunc<void*> run = () => {
        var loop = new MainLoop ();
        session.queue_message (message, (sess, mess) => {
              
          if (!handle_error_from_message (mess, out error)) {
            loop.quit();
          }
          
          var data = message.response_body.data;
          var data_str = ((string) data).substring (0, data.length);

          try {
            var json_obj = parse_json_object (data_str);
            report = new Report (json_obj);
          } catch (Error e) {
            error = e;
          }
          
          loop.quit ();
        });
        loop.run ();
        Idle.add ((owned) callback);
        
        return null;
      };
      
      new Thread<void*> (null, run);
      
      yield;
      
      if (error != null) {
        throw error;
      }
      
      return report;
    }
    
    // Searching for content asynchronously
    // @q : The search query
    // @resolve : Whether to resolve non-local accounts
    // @cancellable : It can be used to cancel the call
    public async Results search_async (string q, bool resolve, Cancellable? cancellable) throws Error {
      
      Error error = null;      
      Results results = null;
      
      var proxy_call = proxy.new_call ();
      setup_search_proxy_call (ref proxy_call, q, resolve);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          results = new Results (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        search_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return results;
    }
    
    // Fetching a status asynchronously
    // @id : The ID of the status
    // @cancellable : It can be used to cancel the call
    public async Status get_status_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;      
      Status status = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_status_proxy_call (ref proxy_call, id);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          status = new Status (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        get_status_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return status;
    }
    
    // Getting status context asynchronously
    // @id : The ID of the status
    // @cancellable : It can be used to cancel the call
    public async Context get_context_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;      
      Context context = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_context_proxy_call (ref proxy_call, id);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          context = new Context (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        get_context_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return context;
    }
    
    // Getting a card associated with a status asynchronously
    // @id : The ID of the status
    // @cancellable : It can be used to cancel the call
    public async Card get_card_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;      
      Card card = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_card_proxy_call (ref proxy_call, id);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          card = new Card (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        get_card_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return card;
    }
    
    // Getting who reblogged a status asynchronously
    // @ranging_params : Parameters to select ranges of reblogged by
    // @next_params : Parameters to select next ranges of reblogged by
    // @prev_params : Parameters to select prev ranges of reblogged by	
    // @cancellable : It can be used to cancel the call
    public async List<Account> get_reblogged_by_async (int64 id, RangingParams? ranging_params, out RangingParams next_params, out RangingParams prev_params, Cancellable? cancellable) throws Error {
      
      next_params = null;
      prev_params = null;
      
      Error error = null;
      var list = new List<Account> ();
      RangingParams _next_params = null;
      RangingParams _prev_params = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_reblogged_by_proxy_call (ref proxy_call, id, ranging_params);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);

          var headers = proxy_call.get_response_headers ();
          parse_links (headers.get ("Link"), out _next_params, out _prev_params);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Account (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_reblogged_by_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      if (_next_params != null) {
        next_params = _next_params;
      }
      if (_prev_params != null) {
        prev_params = _prev_params;
      }
      
      return (owned) list;
    }
    
    // Getting who favourited a status asynchronously
    // @ranging_params : Parameters to select ranges of favoutited by
    // @next_params : Parameters to select next ranges of favoutited by
    // @prev_params : Parameters to select prev ranges of favoutited by
    // @cancellable : It can be used to cancel the call
    public async List<Account> get_favourited_by_async (int64 id, RangingParams? ranging_params, out RangingParams next_params, out RangingParams prev_params, Cancellable? cancellable) throws Error {
      
      next_params = null;
      prev_params = null;
      
      Error error = null;
      var list = new List<Account> ();
      RangingParams _next_params = null;
      RangingParams _prev_params = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_favourited_by_proxy_call (ref proxy_call, id, ranging_params);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);

          var headers = proxy_call.get_response_headers ();
          parse_links (headers.get ("Link"), out _next_params, out _prev_params);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Account (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_favourited_by_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      if (_next_params != null) {
        next_params = _next_params;
      }
      if (_prev_params != null) {
        prev_params = _prev_params;
      }
      
      return (owned) list;
    }
    
    // Postring a new status asynchronously
    // @status : The text of the status
    // @in_reply_to_id : local ID of the status you want to reply to
    // @media_ids : Array of media IDs to attach to the status (maximum 4)
    // @sensitive : Set this to mark the media of the status as NSFW
    // @spoiler_text : (optional)	Text to be shown as a warning before the actual content
    // @visibility : (optional)	Either "direct", "private", "unlisted" or "public"
    // @cancellable : It can be used to cancel the call
    public async Status post_status_async (string status, int64 in_reply_to_id, int64[]? media_ids, bool sensitive, string? spoiler_text, string? visibility, Cancellable? cancellable) throws Error {
      
      Error error = null;
      Status _status = null;
      
      var session = new Soup.Session ();
      var message = post_status_message_new (status, in_reply_to_id, media_ids, sensitive, spoiler_text, visibility);
      
      SourceFunc callback = post_status_async.callback;
      
      ThreadFunc<void*> run = () => {
        var loop = new MainLoop ();
        session.queue_message (message, (sess, mess) => {
              
          if (!handle_error_from_message (mess, out error)) {
            loop.quit();
          }
          
          var data = message.response_body.data;
          var data_str = ((string) data).substring (0, data.length);

          try {
            var json_obj = parse_json_object (data_str);
            _status = new Status (json_obj);
          } catch (Error e) {
            error = e;
          }
          
          loop.quit ();
        });
        loop.run ();
        Idle.add ((owned) callback);
        
        return null;
      };
      
      new Thread<void*> (null, run);
      
      yield;
      
      if (error != null) {
        throw error;
      }
      
      return _status;
    }
    
    // Reblogging a status asynchronously
    // @id : The ID of status to reblog
    // @cancellable : It can be used to cancel the call
    public async Status reblog_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;
      Status status = null;
      
      var proxy_call = proxy.new_call ();
      setup_reblog_proxy_call (ref proxy_call, id);
      
      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          status = new Status (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        reblog_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return status;
    }

    // Unreblogging a status asynchronously
    // @id : The ID of status to unreblog
    // @cancellable : It can be used to cancel the call
    public async Status unreblog_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;
      Status status = null;
      
      var proxy_call = proxy.new_call ();
      setup_unreblog_proxy_call (ref proxy_call, id);
      
      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          status = new Status (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        unreblog_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return status;
    }
    
    // Favouriting a status asynchronously
    // @id : The ID of status to favourite
    // @cancellable : It can be used to cancel the call
    public async Status favourite_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;
      Status status = null;
      
      var proxy_call = proxy.new_call ();
      setup_favourite_proxy_call (ref proxy_call, id);
      
      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          status = new Status (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        favourite_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return status;
    }

    // Unfavouriting a status asynchronously
    // @id : The ID of status to unfavourite
    // @cancellable : It can be used to cancel the call
    public async Status unfavourite_async (int64 id, Cancellable? cancellable) throws Error {
      
      Error error = null;
      Status status = null;
      
      var proxy_call = proxy.new_call ();
      setup_unfavourite_proxy_call (ref proxy_call, id);
      
      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          status = new Status (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        unfavourite_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return status;
    }
    
    // Retrieving home timeline asynchronously
    // @ranging_params : Parameters to select ranges of statuses
    // @next_params : Parameters to select next ranges of statuses
    // @prev_params : Parameters to select prev ranges of statuses
    // @cancellable : It can be used to cancel the call
    public async List<Status> get_home_timeline_async (RangingParams? ranging_params, out RangingParams next_params, out RangingParams prev_params, Cancellable? cancellable) throws Error {
      
      next_params = null;
      prev_params = null;
      
      Error error = null;
      var list = new List<Status> ();
      RangingParams _next_params = null;
      RangingParams _prev_params = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_home_timeline_proxy_call (ref proxy_call, ranging_params);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);

          var headers = proxy_call.get_response_headers ();
          parse_links (headers.get ("Link"), out _next_params, out _prev_params);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Status (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_home_timeline_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      if (_next_params != null) {
        next_params = _next_params;
      }
      if (_prev_params != null) {
        prev_params = _prev_params;
      }
      
      return (owned) list;
    }
    
    // Retrieving public timeline asynchronously
    // @local : Only return statuses originating from this instance
    // @ranging_params : Parameters to select ranges of statuses
    // @next_params : Parameters to select next ranges of statuses
    // @prev_params : Parameters to select prev ranges of statuses
    // @cancellable : It can be used to cancel the call
    public async List<Status> get_public_timeline_async (bool local, RangingParams? ranging_params, out RangingParams next_params, out RangingParams prev_params, Cancellable? cancellable) throws Error {
      
      next_params = null;
      prev_params = null;
      
      Error error = null;
      var list = new List<Status> ();
      RangingParams _next_params = null;
      RangingParams _prev_params = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_public_timeline_proxy_call (ref proxy_call, local, ranging_params);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);

          var headers = proxy_call.get_response_headers ();
          parse_links (headers.get ("Link"), out _next_params, out _prev_params);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Status (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_public_timeline_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      if (_next_params != null) {
        next_params = _next_params;
      }
      if (_prev_params != null) {
        prev_params = _prev_params;
      }
      
      return (owned) list;
    }
    
    // Retrieving hashtag timeline asynchronously
    // @hashtag : The hashtag to search
    // @local : Only return statuses originating from this instance
    // @ranging_params : Parameters to select ranges of statuses
    // @next_params : Parameters to select next ranges of statuses
    // @prev_params : Parameters to select prev ranges of statuses
    // @cancellable : It can be used to cancel the call
    public async List<Status> get_tag_timeline_async (string hashtag, bool local, RangingParams? ranging_params, out RangingParams next_params, out RangingParams prev_params, Cancellable? cancellable) throws Error {
      
      next_params = null;
      prev_params = null;
      
      Error error = null;
      var list = new List<Status> ();
      RangingParams _next_params = null;
      RangingParams _prev_params = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_tag_timeline_proxy_call (ref proxy_call, hashtag, local, ranging_params);
      

      proxy_call.invoke_async.begin (cancellable, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);

          var headers = proxy_call.get_response_headers ();
          parse_links (headers.get ("Link"), out _next_params, out _prev_params);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Status (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_tag_timeline_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      if (_next_params != null) {
        next_params = _next_params;
      }
      if (_prev_params != null) {
        prev_params = _prev_params;
      }
      
      return (owned) list;
    }
  }
}

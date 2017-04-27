using Json;
using Rest;
using Soup;

namespace Gomphotherium {
  
  public class AsyncGomphoApp : GomphoAppBase {
        
    // @website : Instance URL
    // @client_id : Client ID of your GomphoApp
    // @client_secret : Client Secret of your cpplication
    // @access_token : (optional) Your access token
    public AsyncGomphoApp (string website, string client_id, string client_secret, string? access_token = null) {
      base (website, client_id, client_secret, access_token);
    }
    
    // Getting an access token asynchronously
    // @email : A E-mail address of your account
    // @password : Your password
    // @scope : This can be a space-separated list of the following items: "read", "write" and "follow"
    public async string oauth_token_async (string email, string password, string scope) throws Error {
      
      Error error = null;
      
      var proxy_call = proxy.new_call ();
      setup_oauth_proxy_call (ref proxy_call, email, password, scope);
      
      proxy_call.invoke_async.begin (null, (obj, res) => {
          
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
    public async Account get_account_async (int64 id) throws Error {
      
      Error error = null;      
      Account account = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_account_proxy_call (ref proxy_call, id);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
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
    
    // Getting a current user asynchronously
    public async Account verify_credentials_async () throws Error {
      
      Error error = null;
      Account account = null;
      
      var proxy_call = proxy.new_call ();
      setup_verify_credentials_proxy_call (ref proxy_call);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
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
    
    // Getting an account's followers asynchronously
    public async List<Account> get_followers_async (int64 id, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_followers_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
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
      
      return (owned) list;
    }
    
    // Getting an account's following asynchronously
    public async List<Account> get_following_async (int64 id, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_following_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
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
      
      return (owned) list;
    }
    
    // Getting an account's statuses asynchronously
    public async List<Status> get_statuses_async (int64 id, bool only_media = false, bool exclude_replies = false, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Status> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_statuses_proxy_call (ref proxy_call, id, only_media, exclude_replies, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
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
    
    // Getting an account's relationships asynchronously
    public async List<Relationship> get_relationships_async (int64[] ids) throws Error {
      
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

    // Searching for accounts asynchronously
    public async List<Account> search_accounts_async (string q, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_search_accounts_proxy_call(ref proxy_call, q, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
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
    public async List<Account> get_blocks_async (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_blocks_proxy_call (ref proxy_call, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
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
      
      return (owned) list;
    }
    
    // Fetching a user's favourites asynchronously
    public async List<Status> get_favourites_async (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Status> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_favoutrites_proxy_call (ref proxy_call, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
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
      
      return (owned) list;
    }
    
    // Fetching  a list of follow requests asynchronously
    public async List<Account> get_follow_requests_async (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_follow_requests_proxy_call (ref proxy_call, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
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
    
    // Fetching a user's mutes asynchronously
    public async List<Account> get_mutes_async (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_mutes_proxy_call (ref proxy_call, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
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
      
      return (owned) list;
    }
    
    // Fetching a user's notifications asynchronously
    public async List<Gomphotherium.Notification> get_notifications_async (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Gomphotherium.Notification> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_notifications_proxy_call (ref proxy_call, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Gomphotherium.Notification (node.get_object ()));
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
      
      return (owned) list;
    }
    
    // Getting a single notification
    public async Gomphotherium.Notification get_notification_async (int64 id) throws Error {
      
      Error error = null;
      Gomphotherium.Notification notification = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_notification_proxy_call (ref proxy_call, id);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          notification = new Gomphotherium.Notification (json_obj);
          
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
    
    // Fetching a user's reports asynchronously
    public async List<Report> get_reports_async () throws Error {
      
      Error error = null;
      var list = new List<Report> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_reports_proxy_call (ref proxy_call);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
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
    
    // Searching for content asynchronously
    public async Results search_async (string q, bool resolve) throws Error {
      
      Error error = null;      
      Results results = null;
      
      var proxy_call = proxy.new_call ();
      setup_search_proxy_call (ref proxy_call, q, resolve);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
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
    public async Status get_status_async (int64 id) throws Error {
      
      Error error = null;      
      Status status = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_status_proxy_call (ref proxy_call, id);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
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
    public async Context get_context_async (int64 id) throws Error {
      
      Error error = null;      
      Context context = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_context_proxy_call (ref proxy_call, id);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
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
    public async Card get_card_async (int64 id) throws Error {
      
      Error error = null;      
      Card card = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_card_proxy_call (ref proxy_call, id);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
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
    public async List<Account> get_reblogged_by_async (int64 id, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_reblogged_by_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
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
      
      return (owned) list;
    }
    
    // Getting who favourited a status asynchronously
    public async List<Account> get_favourited_by_async (int64 id, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_favourited_by_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
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
      
      return (owned) list;
    }
    
    // Retrieving home timeline asynchronously
    public async List<Status> get_home_timeline_async (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Status> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_home_timeline_proxy_call (ref proxy_call, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
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
      
      return (owned) list;
    }
    
    // Retrieving public timeline asynchronously
    public async List<Status> get_public_timeline_async (bool local = true, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Status> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_public_timeline_proxy_call (ref proxy_call, local, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
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
      
      return (owned) list;
    }
    
    // Retrieving hashtag timeline asynchronously
    public async List<Status> get_tag_timeline_async (string hashtag, bool local = true, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Status> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_tag_timeline_proxy_call (ref proxy_call, hashtag, local, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
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
      
      return (owned) list;
    }
  }
}


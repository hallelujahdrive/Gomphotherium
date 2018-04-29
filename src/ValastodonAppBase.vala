using Json;
using Rest;
using Soup;

namespace Valastodon {
	
	public abstract class ValastodonAppBase : GLib.Object {
		
		// Property-backing fields
		protected string _instance_website;
		protected string _client_key;
		protected string _client_secret;
		protected string _access_token;
		
		protected Rest.Proxy proxy;

		// Propaties
		public string instance_website {
			get { return _instance_website; }
		}
		public string client_key {
			get { return _client_key; }
		}
		public string client_secret {
			get { return _client_secret; }
		}
		public string access_token {
			get { return _access_token; }
		}
		
		// @instance_website : Instance URL
		// @client_key : Client Key of your ValastodonApp
		// @client_secret : Client Secret of your cpplication
		// @access_token : (oprional) An access token of your app
		public ValastodonAppBase (string instance_website, string client_key, string client_secret, string? access_token) {
			_instance_website = instance_website;
			_client_key = client_key;
			_client_secret = client_secret;
			
			proxy = new Rest.Proxy (_instance_website, false);
			
			if (access_token != null){
				_access_token = access_token;
			}
		}
			
		// Users have to go to this url's web page to authorize a your app
		// @scope : This can be a space-separated list of the following items: "read", "write" and "follow"
		// @redirect_uri : (optional) Where the user should be redirected after authorization
		/* public string get_authorization_url (string scope, string? redirect_uri = null) {
			
			if (redirect_uri == null) {
				redirect_uri = "urn:ietf:wg:oauth:2.0:oob";
			}
			
			HashTable<string, string> form = new HashTable<string, string> (str_hash, str_equal);
			form.insert (PARAM_SCOPE, scope.replace(" ", "%20"));
			form.insert (PARAM_RESPONSE_TYPE, "code");
			form.insert (PARAM_REDIRECT_URI, redirect_uri);
			form.insert (PARAM_CLIENT_ID, _client_key);
				
			var url = new Soup.URI (_instance_website);
			url.set_path (ENDPOINT_OAUTH_AUTHORIZE);
			url.set_query_from_form (form);
								
			return url.to_string (false);		
		}*/

		// Set proxy params to authorize with code
		// @code : An authorization code
		protected void setup_authorize_proxy_call (ref ProxyCall proxy_call, string code) {
						
			proxy_call.add_params (PARAM_CLIENT_ID, _client_key, PARAM_CLIENT_SECRET, _client_secret, PARAM_REDIRECT_URI, "urn:ietf:wg:oauth:2.0:oob", PARAM_GRANT_TYPE, "authorization_code", PARAM_CODE, code);
			proxy_call.set_function (ENDPOINT_OAUTH_TOKEN);
			proxy_call.set_method ("POST");
			
		}
		
		// Set proxy params to get an account
		protected void setup_get_account_proxy_call (ref ProxyCall proxy_call, string id) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.set_function (ENDPOINT_ACCOUNTS.printf (id));
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to verify credentials
		protected void setup_verify_credentials_proxy_call (ref ProxyCall proxy_call) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.set_function (ENDPOINT_ACCOUNTS_VERIFY_CREDENTIALS);
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to get followers
		protected void setup_get_followers_proxy_call (ref ProxyCall proxy_call, string id, RangingParams? ranging_params) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			if (ranging_params != null) {
				set_ranging_params_to_proxy_call (ref proxy_call, ranging_params);
			}
			proxy_call.set_function (ENDPOINT_ACCOUNTS_FOLLOWERS.printf (id));
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to get following
		protected void setup_get_following_proxy_call (ref ProxyCall proxy_call, string id, RangingParams? ranging_params) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			if (ranging_params != null) {
				set_ranging_params_to_proxy_call (ref proxy_call, ranging_params);
			}
			proxy_call.set_function (ENDPOINT_ACCOUNTS_FOLLOWING.printf (id));
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to get statuses
		protected void setup_get_statuses_proxy_call (ref ProxyCall proxy_call, string id, bool only_media, bool exclude_replies, RangingParams? ranging_params) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			
			if (only_media) {
				proxy_call.add_param (PARAM_ONLY_MEDIA, only_media.to_string ());
			}
			if (exclude_replies) {
				proxy_call.add_param (PARAM_EXCLUDE_REPLIES, exclude_replies.to_string ());
			}
			if (ranging_params != null) {
				set_ranging_params_to_proxy_call (ref proxy_call, ranging_params);
			}
			proxy_call.set_function (ENDPOINT_ACCOUNTS_STATUSES.printf (id));
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to follow
		protected void setup_follow_proxy_call (ref ProxyCall proxy_call, string id) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);     
			proxy_call.set_function (ENDPOINT_ACCOUNTS_FOLLOW.printf (id));
			proxy_call.set_method ("POST");
			
		}
		
		// Set proxy params to unfollow
		protected void setup_unfollow_proxy_call (ref ProxyCall proxy_call, string id) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);     
			proxy_call.set_function (ENDPOINT_ACCOUNTS_UNFOLLOW.printf (id));
			proxy_call.set_method ("POST");
			
		}    
		
		// Set proxy params to block
		protected void setup_block_proxy_call (ref ProxyCall proxy_call, string id) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);     
			proxy_call.set_function (ENDPOINT_ACCOUNTS_BLOCK.printf (id));
			proxy_call.set_method ("POST");
			
		}
		
		// Set proxy params to unblock
		protected void setup_unblock_proxy_call (ref ProxyCall proxy_call, string id) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);     
			proxy_call.set_function (ENDPOINT_ACCOUNTS_UNBLOCK.printf (id));
			proxy_call.set_method ("POST");
			
		}
		
		// Set proxy params to mute
		protected void setup_mute_proxy_call (ref ProxyCall proxy_call, string id) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);     
			proxy_call.set_function (ENDPOINT_ACCOUNTS_MUTE.printf (id));
			proxy_call.set_method ("POST");
			
		}
		
		// Set proxy params to unmute
		protected void setup_unmute_proxy_call (ref ProxyCall proxy_call, string id) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);     
			proxy_call.set_function (ENDPOINT_ACCOUNTS_UNMUTE.printf (id));
			proxy_call.set_method ("POST");
			
		}
		
		// Set proxy params to search accounts
		protected void setup_search_accounts_proxy_call (ref ProxyCall proxy_call, string q, int limit) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.add_param (PARAM_Q, Uri.escape_string (q));
			
			if (limit >= 0) {
				proxy_call.add_param (PARAM_LIMIT, limit.to_string ());
			}
			
			proxy_call.set_function (ENDPOINT_ACCOUNTS_SEARCH);
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to fetch blocks
		protected void setup_get_blocks_proxy_call (ref ProxyCall proxy_call, RangingParams? ranging_params) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			if (ranging_params != null) {
				set_ranging_params_to_proxy_call (ref proxy_call, ranging_params);
			};
			proxy_call.set_function (ENDPOINT_BLOCKS);
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to fetch favoutites
		protected void setup_get_favoutrites_proxy_call (ref ProxyCall proxy_call, RangingParams? ranging_params) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.set_function (ENDPOINT_FAVOURITES);
			proxy_call.set_method ("GET");
		
		}

		// Set proxy params to fetch follow requests
		protected void setup_get_follow_requests_proxy_call (ref ProxyCall proxy_call, RangingParams? ranging_params) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			if (ranging_params != null) {
				set_ranging_params_to_proxy_call (ref proxy_call, ranging_params);
			}
			proxy_call.set_function (ENDPOINT_FOLLOW_REQUESTS);
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to authorize a follow request
		protected void setup_authorize_follow_request_proxy_call (ref ProxyCall proxy_call, string id) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.set_function (ENDPOINT_FOLLOW_REQUESTS_AUTHORIZE.printf (id));
			proxy_call.set_method ("POST");
			
		}

		// Set proxy params to reject a follow request
		protected void setup_reject_follow_request_proxy_call (ref ProxyCall proxy_call, string id) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.set_function (ENDPOINT_FOLLOW_REQUESTS_REJECT.printf (id));
			proxy_call.set_method ("POST");
			
		}
		
		// Set proxy params to follow a remote user
		protected void setup_remote_follow_proxy_call (ref ProxyCall proxy_call, string uri) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.add_param (PARAM_URI, uri);
			proxy_call.set_function (ENDPOINT_FOLLOWS);
			proxy_call.set_method ("POST");
		
		}
		
		// Set proxy params to get instance information
		protected void setup_get_instance_proxy_call (ref ProxyCall proxy_call) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.set_function (ENDPOINT_INSTANCE);
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to fetch mutes
		protected void setup_get_mutes_proxy_call (ref ProxyCall proxy_call, RangingParams? ranging_params) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			if (ranging_params != null) {
				set_ranging_params_to_proxy_call (ref proxy_call, ranging_params);
			}
			proxy_call.set_function (ENDPOINT_MUTES);
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to fetch notifications
		protected void setup_get_notifications_proxy_call (ref ProxyCall proxy_call, RangingParams? ranging_params) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			if (ranging_params != null) {
				set_ranging_params_to_proxy_call (ref proxy_call, ranging_params);
			}
			proxy_call.set_function (ENDPOINT_NOTIFICATIONS);
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to get a single notification
		protected void setup_get_notification_proxy_call (ref ProxyCall proxy_call, string id) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.set_function (ENDPOINT_NOTIFICATION.printf (id));
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to clear notifications
		protected void setup_clear_notifications_proxy_call (ref ProxyCall proxy_call) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.set_function (ENDPOINT_NOTIFICATIONS_CLIEAR);
			proxy_call.set_method ("POST");
		
		}
		
		// Set proxy params to fetch reports
		protected void setup_get_reports_proxy_call (ref ProxyCall proxy_call) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.set_function (ENDPOINT_REPORTS);
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to search for content
		protected void setup_search_proxy_call (ref ProxyCall proxy_call, string q, bool resolve) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.set_function (ENDPOINT_SEARCH);
			proxy_call.add_param (PARAM_Q, Uri.escape_string (q));
			proxy_call.add_param (PARAM_RESOLVE, resolve.to_string ());
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to fetch a status
		protected void setup_get_status_proxy_call (ref ProxyCall proxy_call, string id) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.set_function (ENDPOINT_STATUSES_ID.printf (id));
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to get status context
		protected void setup_get_context_proxy_call (ref ProxyCall proxy_call, string id) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.set_function (ENDPOINT_STATUSES_CONTEXT.printf (id));
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to get a card associated with status
		protected void setup_get_card_proxy_call (ref ProxyCall proxy_call, string id) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.set_function (ENDPOINT_STATUSES_CARD.printf (id));
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to get who reblogged a status
		protected void setup_get_reblogged_by_proxy_call (ref ProxyCall proxy_call, string id, RangingParams? ranging_params) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			if (ranging_params != null) {
				set_ranging_params_to_proxy_call (ref proxy_call, ranging_params);
			}
			proxy_call.set_function (ENDPOINT_STATUSES_REBLOGGED_BY.printf (id));
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to get who favourited a status
		protected void setup_get_favourited_by_proxy_call (ref ProxyCall proxy_call, string id, RangingParams? ranging_params) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			if (ranging_params != null) {
				set_ranging_params_to_proxy_call (ref proxy_call, ranging_params);
			}
			proxy_call.set_function (ENDPOINT_STATUSES_FAVOURITED_BY.printf (id));
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to reblog a status
		protected void setup_reblog_proxy_call (ref ProxyCall proxy_call, string id) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.set_function (ENDPOINT_STATUSES_REBLOG.printf (id));
			proxy_call.set_method ("POST");
			
		}
		
		// Set proxy params to unreblog a status
		protected void setup_unreblog_proxy_call (ref ProxyCall proxy_call, string id) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.set_function (ENDPOINT_STATUSES_UNREBLOG.printf (id));
			proxy_call.set_method ("POST");
			
		}

		// Set proxy params to favourite a status
		protected void setup_favourite_proxy_call (ref ProxyCall proxy_call, string id) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.set_function (ENDPOINT_STATUSES_FAVOURITE.printf (id));
			proxy_call.set_method ("POST");
			
		}
		
		// Set proxy params to unfavourite a status
		protected void setup_unfavourite_proxy_call (ref ProxyCall proxy_call, string id) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			proxy_call.set_function (ENDPOINT_STATUSES_UNFAVOURITE.printf (id));
			proxy_call.set_method ("POST");
			
		}
		
		// Set proxy params to get home timeline
		protected void setup_get_home_timeline_proxy_call (ref ProxyCall proxy_call, RangingParams? ranging_params) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			if (ranging_params != null) {
				set_ranging_params_to_proxy_call (ref proxy_call, ranging_params);
			}
			proxy_call.set_function (ENDPOINT_TIMELINES_HOME);
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to get public timeline
		protected void setup_get_public_timeline_proxy_call (ref ProxyCall proxy_call, bool local, RangingParams? ranging_params) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			if (ranging_params != null) {
				set_ranging_params_to_proxy_call (ref proxy_call, ranging_params);
			}
			if (local) {
				proxy_call.add_param (PARAM_LOCAL, "");
			}
			
			proxy_call.set_function (ENDPOINT_TIMELINES_PUBLIC);
			proxy_call.set_method ("GET");
		
		}
		
		// Set proxy params to get tag timeline
		protected void setup_get_tag_timeline_proxy_call (ref ProxyCall proxy_call,string hashtag, bool local, RangingParams? ranging_params) {
			
			proxy_call.add_header ("Authorization"," Bearer " + _access_token);
			if (ranging_params != null) {
				set_ranging_params_to_proxy_call (ref proxy_call, ranging_params);
			}   
			if (local) {
				proxy_call.add_param (PARAM_LOCAL, "");
			}
			
			proxy_call.set_function (ENDPOINT_TIMELINES_TAG.printf (Uri.escape_string (hashtag)));
			proxy_call.set_method ("GET");
		
		}
		
		// Generate a soup message to update credentials
		protected Soup.Message update_credentials_message_new (string? display_name, string? note, File? avatar, File? header) {
			
			var message = new Soup.Message ("PATCH", _instance_website + ENDPOINT_ACCOUNTS_UPDATE_CREDENTIALS);
			var sb = new StringBuilder ();
			
			if (display_name != null) {
				sb.append (PARAM_DISPLAY_NAME);
				sb.append ("=");
				sb.append (Uri.escape_string (display_name));
				sb.append ("&");
			}
			if (note != null) {
				sb.append (PARAM_NOTE);
				sb.append ("=");
				sb.append (Uri.escape_string (note));
				sb.append ("&");
			}
			if (avatar != null) {
				try {
					var avatar_base64 = file_to_base64_encoded (avatar);
					sb.append (PARAM_AVATAR);
					sb.append ("=");
					sb.append (Uri.escape_string (avatar_base64));
					sb.append ("&");
				} catch (Error e) {
					stderr.printf ("%s\n", e.message);
				}
			}
			if (header != null) {
				try {
					var header_base64 = file_to_base64_encoded (header);
					sb.append (PARAM_HEADER);
					sb.append ("=");
					sb.append (Uri.escape_string (header_base64));
					sb.append ("&");
				} catch (Error e) {
					stderr.printf ("%s\n", e.message);
				}
			}
			
			message.request_headers.append ("Authorization"," Bearer " + _access_token);
			message.set_request ("application/x-www-form-urlencoded", Soup.MemoryUse.COPY, sb.str.data);
			
			return message;
		}
		
		// Generate a soup message to get relatiopnships
		protected Soup.Message relationships_message_new (string[] ids) {
			
			var message = new Soup.Message ("GET", _instance_website + ENDPOINT_ACCOUNTS_RELATIONSHIPS);
			var sb = new StringBuilder ();
			
			int i = 0;
			foreach (string id in ids) {
				sb.append (PARAM_ID);
				sb.append ("[]=");
				sb.append (id);
				if (++i < ids.length) {
					sb.append ("&");
				}
			}
			
			message.request_headers.append ("Authorization"," Bearer " + _access_token);
			message.set_request ("application/x-www-form-urlencoded", Soup.MemoryUse.COPY, sb.str.data);
			
			return message;
		
		}
		
		// Generate a soup message to upload a media
		protected Soup.Message upload_media_message_new (File file) throws Error {
			
			try {
			
				var info = file.query_info ("*", FileQueryInfoFlags.NONE);
				
				var dis = new DataInputStream (file.read ());
				var bytes = dis.read_bytes ((size_t) info.get_size ());
				
				var buffer = new Buffer.take (bytes.get_data ());
				var multipart = new Multipart ("multipart/form-data");
				
				multipart.append_form_file (PARAM_FILE, info.get_display_name (), info.get_content_type (), buffer);
				
				var message = Soup.Form.request_new_from_multipart (_instance_website + ENDPOINT_MEDIA, multipart);
				message.request_headers.append ("Authorization"," Bearer " + _access_token);
				
				return message;
				
			} catch (Error e) {
				throw e;
			}
		}
		
		// Generate a soup message to report a user
		protected Soup.Message report_message_new (string account_id, string[] status_ids, string comment) throws Error {
			
			var message = new Soup.Message ("POST", _instance_website + ENDPOINT_REPORTS);
			var sb = new StringBuilder ();
			
			sb.append (PARAM_ACCOUNT_ID);
			sb.append ("=");
			sb.append (account_id);
			sb.append ("&");
			foreach (string id in status_ids) {
				sb.append (PARAM_STATUS_IDS);
				sb.append ("[]=");
				sb.append (id);
				sb.append ("&");
			}
			sb.append (PARAM_COMMENT);
			sb.append ("=");
			sb.append (Uri.escape_string (comment));
			
			message.request_headers.append ("Authorization"," Bearer " + _access_token);
			message.set_request ("application/x-www-form-urlencoded", Soup.MemoryUse.COPY, sb.str.data);
			
			return message;
		}
		
		// Generate a soup message to post a new status
		protected Soup.Message post_status_message_new (string status, string? in_reply_to_id, string[]? media_ids, bool sensitive, string? spoiler_text, string? visibility) throws Error {
			
			var message = new Soup.Message ("POST", _instance_website + ENDPOINT_STATUSES);
			var sb = new StringBuilder ();
			
			sb.append (PARAM_STATUS);
			sb.append ("=");
			sb.append (Uri.escape_string (status));
			
			if (in_reply_to_id != null) {
				sb.append ("&");
				sb.append (PARAM_IN_REPLY_TO_ID);
				sb.append ("=");
				sb.append (in_reply_to_id);
			}
			
			if (media_ids != null && media_ids.length > 0) {
				foreach (string id in media_ids) {
					sb.append ("&");
					sb.append (PARAM_MEDIA_IDS);
					sb.append ("[]=");
					sb.append (id);
				}
			}
			
			if (sensitive) {
				sb.append ("&");
				sb.append (PARAM_SENSITIVE);
				sb.append ("=");
				sb.append (sensitive.to_string ());
			}
			
			if (spoiler_text != null) {
				sb.append ("&");
				sb.append (PARAM_SPOILER_TEXT);
				sb.append ("=");
				sb.append (Uri.escape_string (spoiler_text));
			}
			
			if (visibility != null) {
				sb.append ("&");
				sb.append (PARAM_VISIBILITY);
				sb.append ("=");
				sb.append (visibility);
			}
			
			message.request_headers.append ("Authorization"," Bearer " + _access_token);
			message.set_request ("application/x-www-form-urlencoded", Soup.MemoryUse.COPY, sb.str.data);
			
			return message;
		}
		
		protected void set_ranging_params_to_proxy_call (ref ProxyCall proxy_call, RangingParams ranging_params) {
			
			if (ranging_params.max_id != null) {
				proxy_call.add_param (PARAM_MAX_ID, ranging_params.max_id);
			}
			if (ranging_params.since_id != null) {
				proxy_call.add_param (PARAM_SINCE_ID, ranging_params.since_id);
			}
			if (ranging_params.limit >= 0) {
				proxy_call.add_param (PARAM_LIMIT, ranging_params.limit.to_string ());
			}
		}
		
		protected void parse_links (string links, out RangingParams next_params, out RangingParams prev_params) {
			
			next_params = null;
			prev_params = null;
			
			try {
				var splited = links.split (",");
				
				var regex = new Regex ("<https://[a-zA-z0-9/._]+\\?|>; ");
				
				foreach (string frag in splited) {
					
					var link = regex.split (frag); // return string[3]; ["", "parameters", "rel=..."]
					var rel_regex = new Regex ("\"|rel=");
					string rel = rel_regex.replace (link[2], link[2].length, 0, "");
					switch (rel) {
						case "prev" :
						case "previous" :
							prev_params = new RangingParams.new_from_query (link[1]);
							break;
						case "next" :
							next_params = new RangingParams.new_from_query (link[1]);
							return;
					}
				}
				
			} catch (Error e) {
				stderr.printf ("%s\n",e.message);
			}
		}
	}
}

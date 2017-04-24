using Json;

namespace Gomphotherium {
  
  public class Status {
    
    // Property-backing fields
    private int64 _id;  // The ID of the status
    private string _uri;  // A Fediverse-unique resource ID
    private string _url;  // URL to the status page (can be remote)
    private Account _account; // The Account which posted the status
    private int64 _in_reply_to_id;  // null or the ID of the status it replies to
    private int64 _in_reply_to_account_id;  // null or the ID of the account it replies to
    private Status _reblog; // null or the reblogged Status
    private string _content;  // Body of the status; this will contain HTML (remote HTML already sanitized)
    private string _created_at; // The time the status was created
    private int64 _reblogs_count; // The number of reblogs for the status
    private int64 _favourites_count; // The number of favourites for the status
    private bool _reblogged; // Whether the authenticated user has reblogged the status
    private bool _favourited;  // Whether the authenticated user has favourited the status
    private bool _sensitive;  // Whether media attachments should be hidden by default
    private string _spoiler_text; // If not empty, warning text that should be displayed before the actual content
    private string _visibility; // One of: public, unlisted, private, direct
    private List<Attachment> _media_attachments = new List<Attachment> ();  // An array of Attachments
    private List<Mention> _mentions = new List<Mention> ();  // An array of Mentions
    private List<Tag> _tags = new List<Tag> ();  // An array of Tags
    private Application _application; // Application from which the status was posted
    
    // Properties
    public int64 id {
      get { return _id; }
    }
    public string uri {
      get { return _uri; }
    }
    public string url {
      get { return _url; }
    }
    public weak Account account {
      get { return _account; }
    }
    public int64? in_reply_to_id {
      get { return _in_reply_to_id; }
    }
    public int64? in_reply_to_account_id {
      get { return _in_reply_to_account_id; }
    }
    public weak Status? reblog {
      get { return _reblog; }
    }
    public string content {
      get { return _content; }
    }
    public string created_at{
      get { return _created_at; }
    }
    public int64 reblogs_count {
      get { return _reblogs_count; }
    }
    public int64 favourites_count {
      get { return _favourites_count; }
    }
    public bool reblogged {
      get { return _reblogged; }
    }
    public bool favourited {
      get { return _favourited; }
    }
    public bool sensitive {
      get { return _sensitive; }
    }
    public string spoiler_text{
      get { return _spoiler_text; }
    }
    public string visibility{
      get { return _visibility; }
    }
    public List<Attachment> media_attachments {
      get { return _media_attachments; }
    }
    public List<Mention> mentions {
      get { return _mentions; }
    }
    public List<Tag> tags {
      get { return _tags; }
    }
    public weak Application? application {
      get { return _application; }
    }
    
    internal Status (Json.Object json_obj) {
      
      json_obj.foreach_member ((obj, mem, node) => {
        
        switch (mem) {
          case "id" : _id = node.get_int ();
          break;
          case "uri" : _uri = node.get_string ();
          break;
          case "url" : _url = node.get_string ();
          break;
          case "account" : _account = new Account (node.get_object ());
          break;
          case "in_reply_to_id" : _in_reply_to_id = node.get_int ();
          break;
          case "in_reply_to_account_id": _in_reply_to_account_id = node.get_int ();
          break;
          case "reblog" :
          if (node.get_node_type () != NodeType.NULL) {
            _reblog = new Status (node.get_object ());
          }
          break;
          case "content" : _content = node.get_string ();
          break;
          case "created_at" : _created_at = node.get_string ();
          break;
          case "reblogs_count" : _reblogs_count = node.get_int ();
          break;
          case "favourites_count" : _favourites_count = node.get_int ();
          break;
          case "reblogged" : _reblogged = node.get_boolean ();
          break;
          case "favourited" : _favourited = node.get_boolean ();
          break;
          case "sensitive" : _sensitive = node.get_boolean ();
          break;
          case "spoiler_text" : _spoiler_text = node.get_string ();
          break;
          case "visibility" : _visibility = node.get_string ();
          break;
          case "media_attachments" :
          node.get_array ().foreach_element ((array, index, node) => {
            _media_attachments.append (new Attachment (node.get_object ()));
          });
          break;
          case "mentions" :
          node.get_array ().foreach_element ((array, index, node) => {
            _mentions.append (new Mention (node.get_object ()));
          });
          break;
          case "tags" :
          node.get_array ().foreach_element ((array, index, node) => {
            _tags.append (new Tag (node.get_object ()));
          });
          break;
          case "application" :
          if (node.get_node_type () != NodeType.NULL) {
            _application = new Application (node.get_object ());
          }
          break;
        }
        
      });
      
    }
  }
}

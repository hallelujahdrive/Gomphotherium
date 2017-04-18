using Json;

namespace Gomphoterium {
  
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
    private int64 _favorites_count; // The number of favourites for the status
    private bool _reblogged; // Whether the authenticated user has reblogged the status
    private bool _favorited;  // Whether the authenticated user has favourited the status
    private bool _sensitive;  // Whether media attachments should be hidden by default
    private string _spoiler_text; // If not empty, warning text that should be displayed before the actual content
    private string _visibility; // One of: public, unlisted, private, direct
    private List<Attachment> _media_attachments;  // An array of Attachments
    private List<Mention> _mentions;  // An array of Mentions
    private List<Tag> _tags;  // An array of Tags
    private Application _application; // Application from which the status was posted
    
    // Properties
    private int64 id {
      get { return _id; }
    }
    public unowned string uri {
      get { return _uri; }
    }
    public unowned string url {
      get { return _url; }
    }
    public weak Account account {
      get { return _account; }
    }
    private int64? in_reply_to_id {
      get { return _in_reply_to_id; }
    }
    private int64? in_reply_to_account_id {
      get { return _in_reply_to_account_id; }
    }
    private weak Status? reblog {
      get { return _reblog; }
    }
    public unowned string content {
      get { return _content; }
    }
    public unowned string created_at{
      get { return _created_at; }
    }
    public int64 reblogs_count {
      get { return _reblogs_count; }
    }
    public int64 favorites_count {
      get { return _favorites_count; }
    }
    public bool reblogged {
      get { return _reblogged; }
    }
    public bool favorited {
      get { return _favorited; }
    }
    public bool sensitive {
      get { return _sensitive; }
    }
    public unowned string spoiler_text{
      get { return _spoiler_text; }
    }
    public unowned string visibility{
      get { return _visibility; }
    }
    public unowned List<Attachment> media_attachments {
      get { return _media_attachments; }
    }
    public unowned List<Mention> mentions {
      get { return _mentions; }
    }
    public weak Application application {
      get { return _application; }
    }
    
    internal Status (Json.Object json_obj) {
      
    }
  }
}

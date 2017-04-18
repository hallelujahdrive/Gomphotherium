using Json;

namespace Gomphoterium {
  
  public class Attachment {
    
    // Property-backing fields
    private int64 _id;  // ID of the attachment
    private string _type; // One of: "image", "video", "gifv"
    private string _url;  // URL of the locally hosted version of the image
    private string _remote_url; // For remote images, the remote URL of the original image
    private string _preview_url;  // URL of the preview image
    private string _text_url; // Shorter URL for the image, for insertion into text (only present on local images)
    
    // Properties
    public int64 id {
      get { return _id; }
    }
    public unowned string media_type {
      get { return _type; }
    }
    public unowned string url {
      get { return _url; }
    }
    public unowned string remote_url {
      get { return _remote_url; }
    }
    public unowned string preview_url {
      get { return _preview_url; }
    }
    public unowned string text_url {
      get { return _text_url; }
    }
    
    internal Attachment (Json.Object json_obj) {
      
    }
    
  }
}


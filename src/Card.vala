using Json;

namespace Gomphotherium {
  
  public class Card {
    
    // Property-backing fields
    private string _url;  // The url associated with the card
    private string _title;  // The title of the card
    private string _description;  // The card description
    private string _image;  // The image associated with the card, if any]
    
    // Properties
    public unowned string url {
      get { return _url; }
    }
    public unowned string title {
      get { return _title; }
    }
    public unowned string description {
      get { return _description; }
    }
    public unowned string image {
      get { return _image; }
    }
    
    internal Card (Json.Object json_obj) {
      
      json_obj.foreach_member ((obj, mem, node) => {
        
        switch (mem) {
          case "url" : _url = node.get_string ();
          break;
          case "title" : _title = node.get_string ();
          break;
          case "description" : _description = node.get_string ();
          break;
          case "image" : _image = node.get_string ();
          break;
        }
        
      });
      
    }
  }
}

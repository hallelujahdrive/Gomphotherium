using Json;

namespace Valastodon {
	
	public class Attachment {
		
		// Property-backing fields
		private string _id;  // ID of the attachment
		private string _type; // One of: "image", "video", "gifv"
		private string _url;  // URL of the locally hosted version of the image
		private string _remote_url; // (Nullable) For remote images, the remote URL of the original image
		private string _preview_url;  // URL of the preview image
		private string _text_url; // (Nullable) Shorter URL for the image, for insertion into text (only present on local images)
		private List<Metadata> _meta;
		private string _description; // (Nullable) A description of the image for the visually impaired (maximum 420 characters), or null if none provided
		
		// Properties
		public string id {
			get { return _id; }
		}
		public string media_type {
			get { return _type; }
		}
		public string url {
			get { return _url; }
		}
		public string? remote_url {
			get { return _remote_url; }
		}
		public string preview_url {
			get { return _preview_url; }
		}
		public string? text_url {
			get { return _text_url; }
		}
		
		internal Attachment (Json.Object json_obj) {
			
			json_obj.foreach_member ((obj, mem, node) => {
				
				switch (mem) {
					case "id" : _id = node.get_string ();
					break;
					case "type" : _type = node.get_string ();
					break;
					case "url" : _url = node.get_string ();
					break;
					case "remote_url" : _remote_url = node.get_string ();
					break;
					case "preview_url" : _preview_url = node.get_string ();
					break;
					case "text_url" : _text_url = node.get_string ();
					break;
				}
				
			});
			
		}
	}
}


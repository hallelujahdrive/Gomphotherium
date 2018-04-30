using Json;

namespace Valastodon {
	
	public class Card {
		
		// Property-backing fields
		private string _url;  // The url associated with the card
		private string _title;  // The title of the card
		private string _description;  // The card description
		private string _image;  // (Nullable) The image associated with the card, if any
		private string _type; // "link", "photo", "video", or "rich"
		private string _author_name; // (Nullable) Embed data
		private string _author_url; // (Nullable) Embed data
		private string _provider_name; // (Nullable) Embed data
		private string _provider_url; // (Nullable) Embed data
		private string _html; // (Nullable) Embed data
		private int _width; // (Nullable) Embed data
		private int _height; // (Nullable) Embed data
		
		// Properties
		public string url {
			get { return _url; }
		}
		public string title {
			get { return _title; }
		}
		public string description {
			get { return _description; }
		}
		public string? image {
			get { return _image; }
		}
		public string content_type {
			get { return _type; }
		}
		public string? author_name {
			get { return _author_name; }
		}
		public string? author_url {
			get { return _author_url; }
		}
		public string? provider_name {
			get { return _provider_name; }
		}
		public string? provider_url {
			get { return provider_url; }
		}
		public string html {
			get { return _html; }
		}
		public int width {
			get { return _width; }
		}
		public int height {
			get { return _height; }
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

using Json;

namespace Valastodon {
	
	public class Instance {
		
		// Propery-backing fields
		private string _url;  // URI of the current instance
		private string _title;  // The instance's title
		private string _description;  // A description for the instance
		private string _email;  // An email address which can be used to contact the instance administrator
		private string _version; // The Mastodon version used by instance.
		private string _urls; // streaming_api
		private List<string> _languages = new List<string> (); // Array of ISO 6391 language codes the instance has chosen to advertise
		private string _contact_account; // Account of the admin or another contact person
		
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
		public string email {
			get { return _email; }
		}
		
		internal Instance (Json.Object json_obj) {
			
			json_obj.foreach_member ((obj, mem, node) => {
				
				switch (mem) {
					case "url" : _url = node.get_string ();
					break;
					case "title" : _title = node.get_string ();
					break;
					case "description" : _description = node.get_string ();
					break;
					case "email" : _email = node.get_string ();
					break;
				}
				
			});
		} 
	}
}

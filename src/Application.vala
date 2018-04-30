using Json;

namespace Valastodon {
	
	public class Application {
		
		// Property-backing fields
		private string _name; // Name of the app
		private string _website;  // (Nullable) Homepage URL of the app
		
		// Propaties
		public string name {
			get { return _name; }
		}
		public string? website {
			get { return _website; }
		}
		
		internal Application (Json.Object json_obj) {
			
			json_obj.foreach_member ((obj, mem, node) => {
				
				switch (mem) {
					case "name" : _name = node.get_string ();
					break;
					case "website" : _website = node.get_string ();
					break;
				}
				
			});
			
		}
	}
}

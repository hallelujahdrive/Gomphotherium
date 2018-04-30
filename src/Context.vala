using Json;

namespace Valastodon {
	
	public class Context {
		
		// Property-backing fields
		private List<Status> _ancestors = new List<Status> ();  // The ancestors of the status in the conversation, as a list of Statuses
		private List<Status> _descendants = new List<Status> ();  // The descendants of the status in the conversation, as a list of Statuses
		
		//Properties
		public List<Status> ancestors {
			get { return _ancestors; }
		}
		public List<Status> descendants {
			get { return _descendants; }
		}
		
		internal Context (Json.Object json_obj) {
			
			json_obj.foreach_member ((obj, mem, node) => {
				
				switch (mem) {
				case "ancestors" :
				node.get_array ().foreach_element ((array, index, node) => {
					_ancestors.append (new Status (node.get_object ()));
				});
				break;
				case "descendants" :
				node.get_array ().foreach_element ((array, index, node) => {
					_descendants.append (new Status (node.get_object ()));
				});
				break;
			}
				
			});
			
		}
	}
}

namespace Valastodon {
	
	[Compact]
	[Immutable]
	public class RangingParams {
		
		// Properties
		public string max_id;
		public string since_id;
		public int limit;
		
		// @max_id : (oprional) Get a list of items with ID less than or equal this value
		// @since_id : (optional) Get a list of items with ID greater than this value
		// @limit : (optional) Maximum number of items to get
		public RangingParams (string? max_id = null, string? since_id = null, int limit = -1) {
			this.max_id = max_id;
			this.since_id = since_id;
			this.limit = limit;
		}
		
		// @query : The query of the url returned from a request
		public RangingParams.new_from_query (string query) {
			
			string _max_id = null;
			string _since_id = null;
			int _limit = -1;
			
			try {
				var regex = new Regex ("=|&");
				var splited = regex.split (query);
				
				var hashtable = new HashTable<string, string> (str_hash, str_equal);
				
				for (int i = 0; i < splited.length; i = i + 2) {
					hashtable.insert (splited[i], splited[i + 1]);
				}
				
				_max_id = hashtable.get ("max_id");

				_since_id = hashtable.get ("since_id");
				
				string limit_str = hashtable.get ("limit");
				
				if (limit_str != null) {
					_limit = int.parse (limit_str);
				}
			} catch (Error e) {
				stderr.printf ("%s\n",e.message);
			}
			
			this (_max_id, _since_id, _limit);
		}
	}
}

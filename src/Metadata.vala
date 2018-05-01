namespace Valastodon {
	
	[Compact]
	[Immutable]
	public class Meta {
		private int64 _width;
		private int64 _height;
		private string _size;
		private double _aspect;
		private int64 _frame_rate;
		private int64 _duration;
		private int64 _bitrate;
		
		public int64 width {
			get { return _width; }
		}
		public int64 height {
			get { return _height; }
		}
		public string size {
			get { return _get; }
		}
		public double aspect {
			get { return aspect; }
		}
		
		internal ImageMeta (Json.Object obj) {
			
		}
	}	
	
	[Compact]
	[Immutable]
	public class Metadata {
		
		private ImageMeta _original;
		private ImageMeta _small;
		
		
		private string _description;
		
		public unowned ImageMeta? original {
			get { return _original; }
		}
		public unowned ImageMeta? small {
			get { return _small; }
		}
		
		public string? descendants {
			get { return _description; }
		}
		
		internal Metadata (Json.Object obj) {
		}
	} 
}

public Json.Object load_test_datas () {
	
	Json.Object obj = null;
	string file_name = "test_datas.json";
	
	try {
		string read = "";
		FileUtils.get_contents (file_name, out read);
		
		var node = Json.from_string (read);
		
		obj = node.get_object ();
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
	}
	
	return obj;
}

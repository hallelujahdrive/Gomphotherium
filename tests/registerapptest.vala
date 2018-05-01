void register_app () {
	
	var obj = load_test_datas ();

	string client_name = "valastodon_test";
	string scopes = "read write follow";
	
	try {
		
		var regex = new Regex ("[0-9a-z]{64}");
		
		var result = Valastodon.register_app (obj.get_string_member ("instance_website"), client_name, null, scopes, null);
		
		assert (regex.match_all_full (result.client_key));
		assert (regex.match_all_full (result.client_secret));
		
		stdout.printf ("\nclient_key : %s\n", result.client_key);
		stdout.printf ("client_secret : %s\n", result.client_secret);
			
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
	}
	
}

int main (string[] args) {
	GLib.Test.init (ref args);
	
	GLib.Test.add_func ("/registerapptest/registring_app", register_app);
	
	return GLib.Test.run ();
}

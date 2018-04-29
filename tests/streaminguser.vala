void streaming_user () {
	
	var loop = new MainLoop ();
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
	
	var stream = new Valastodon.UserStream (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	try {
		
		if (stream.continuous ((event, object) => {
			switch (event) {
				case "delete" : stdout.printf ("%s :\n%" + int64.FORMAT + "\n", event, ((Valastodon.Delete) object).id);
				break;
				case "notification" :
				stdout.printf ("%s :\n", event);
				print_notification ((Valastodon.Notification) object);
				break;
				case "update" :
				stdout.printf ("%s :\n", event);
				print_status ((Valastodon.Status) object);
				break;
			}
		})) {
			stdout.printf ("return\n");
		}
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);    
	}
	
	loop.run ();
}

int main (string[] args) {
	
	GLib.Test.init (ref args);
	
	GLib.Test.add_func ("/streaminguser/streaming_user", streaming_user);
	
	return GLib.Test.run ();
}


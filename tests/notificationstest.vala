void get_notifications () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
		
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	string[] ids = {"5500062", "5500083", "5500098", "5500124", "5500213"};
	
	try {
		foreach (string id in ids) {
			app.favourite (id);
		}    
	} catch (Error e) {
		stdout.printf ("%s\n", e.message);
	}
	
	
	var account_obj_2 = obj.get_array_member ("accounts").get_object_element (1);
		
	var app_2 = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj_2.get_string_member ("access_token"));
	
	try {
		
		var list = app_2.get_notifications ();
		assert (list.length () > 0);    
		var notification = app_2.get_notification (list.nth_data (0).id);
		assert (notification.id == list.nth_data (0).id);
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
		assert (false);
	}
}

void clear_notifications () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (1);
		
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	string[] ids = {"5500062", "5500083", "5500098", "5500124", "5500213"};
	
	try {
		app.clear_notifications ();
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
		assert (false);
	}

	// hallelujahdrive's access_token
	var account_obj_2 = obj.get_array_member ("accounts").get_object_element (0);
	var app_2 = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj_2.get_string_member ("access_token"));
	
	try {
		foreach (string id in ids) {
			app_2.unfavourite (id);
		}    
	} catch (Error e) {
		stdout.printf ("%s\n", e.message);
	}
}

int main (string[] args) {
	
	GLib.Test.init (ref args);
	
	GLib.Test.add_func ("/notificationstest/getnotifications", get_notifications);
	GLib.Test.add_func ("/notificationstest/clearnotitications", clear_notifications);
	
	return GLib.Test.run ();
	
}

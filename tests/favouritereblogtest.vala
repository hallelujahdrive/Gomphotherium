void reblog () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (1);
	// https://mstdn.jp/web/statuses/5049643
	string status_id = "5049643";
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	// reblog
	try {
		
		var status = app.reblog (status_id);
				
		assert (status != null);
		assert (status.reblog.id == status_id);
		assert (status.reblogged);
		assert (status.reblog.reblogged);
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);    
		assert (false);
	}
	
	// get reblogged by
	var account_obj_2 = obj.get_array_member ("accounts").get_object_element (0);
	
	var app_2 = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj_2.get_string_member ("access_token"));
	try {
		
		var accounts = app_2.get_reblogged_by (status_id);
		
		assert (accounts.length () > 0);
		assert (accounts.nth_data (accounts.length () - 1).id == account_obj.get_string_member ("id"));
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
		assert (false);
	}
}

void unreblog () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (1);
	// https://mstdn.jp/web/statuses/5049643
	string status_id = "5049643";
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	try {
		
		var status = app.unreblog (status_id);
		
		assert (status != null);
		assert (status.id == status_id);
		assert (!status.reblogged);
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);    
		assert (false);
	}
}

void favourite () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (1);
	// https://mstdn.jp/web/statuses/5049547
	string status_id = "5049547";
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	
	// favourite
	try {

		var status = app.favourite (status_id);
		
		assert (status != null);
		assert (status.id == status_id);
		assert (status.favourited);
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);    
		assert (false);
	}
	
	// get favourites
	try {
		
		var statuses = app.get_favourites ();
		
		assert (statuses.length () > 0);
		assert (statuses.nth_data (statuses.length () - 1).id == status_id);
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
	}
	
	// get favourited by
	var account_obj_2 = obj.get_array_member ("accounts").get_object_element (0);

	var app_2 = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj_2.get_string_member ("access_token"));
	
	try {
		
		var accounts = app_2.get_favourited_by (status_id);
		
		assert (accounts.length () > 0);
		assert (accounts.nth_data (accounts.length () - 1).id == account_obj.get_string_member ("id"));
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
		assert (false);
	}
}

void unfavourite () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (1);
	// https://mstdn.jp/web/statuses/5049547
	string status_id = "5049547";
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	try {

		var status = app.unfavourite (status_id);
		
		assert (status != null);
		assert (status.id == status_id);
		assert (!status.favourited);
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);    
		assert (false);
	}
}

int main (string[] args) {
	
	GLib.Test.init (ref args);
	
	GLib.Test.add_func ("/reblogreblogtest/reblog", reblog);
	GLib.Test.add_func ("/reblogreblogtest/unreblog", unreblog);
	GLib.Test.add_func ("/favouritereblogtest/favourite", favourite);
	GLib.Test.add_func ("/favouritereblogtest/unfavourite", unfavourite);
	
	return GLib.Test.run ();
	
}

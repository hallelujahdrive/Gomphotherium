void post_status () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (1);
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	try {
		
		var regex = new Regex ("This is a test toot\\.");
		
		var status = app.post_status ("This is a test toot.");
		assert (status != null);
		assert (regex.match (status.content));
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
		assert (false);
	}
}

void post_status_reply () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (1);
	string account_id = obj.get_array_member ("accounts").get_object_element (0).get_string_member ("id");
	string in_reply_to_id = "6016005";

	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	try {
		
		var regex = new Regex ("This is a reply test toot\\.");
		
		var status = app.post_status ("This is a reply test toot.", in_reply_to_id);
		assert (status != null);
		assert (regex.match (status.content));
		assert (status.in_reply_to_account_id == account_id);
		assert (status.in_reply_to_id == in_reply_to_id);
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
		assert (false);
	}
}

void post_status_sensitive () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (1);
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	try {
		
		var regex = new Regex ("This is a sensitive test toot\\.");
		
		var status = app.post_status ("This is a sensitive test toot.", null, null, true);
		assert (status != null);
		assert (regex.match (status.content));
		assert (status.sensitive);
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
		assert (false);
	}
}

void post_status_spoiler_text () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (1);
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	try {
		
		var regex = new Regex ("This is a spoiler text test toot\\.");
		var regex_2 = new Regex ("This is a spiler text.");
		
		var status = app.post_status ("This is a spoiler text test toot.", null, null, false, "This is a spiler text.");
		assert (status != null);
		assert (regex.match (status.content));
		assert (regex_2.match (status.spoiler_text));
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
		assert (false);
	}
}

void post_status_visibility_direct () {
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (1);
	string in_reply_to_id = "6016005";
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	try {
		
		var regex = new Regex ("This is a visibility \\(direct\\) test toot\\.");
		
		var status = app.post_status ("This is a visibility (direct) test toot.", in_reply_to_id, null, false, null, "direct");
		assert (status != null);
		assert (regex.match (status.content));
		assert (status.visibility == "direct");
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
		assert (false);
	}
}

void post_status_visibility_private () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (1);
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	try {
		
		var regex = new Regex ("This is a visibility \\(private\\) test toot\\.");
		
		var status = app.post_status ("This is a visibility (private) test toot.", null, null, false, null, "private");
		assert (status != null);
		assert (regex.match (status.content));
		assert (status.visibility == "private");
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
		assert (false);
	}
}

void post_status_visibility_unlisted () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (1);
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	try {
		
		var regex = new Regex ("This is a visibility \\(unlisted\\) test toot\\.");
		
		var status = app.post_status ("This is a visibility (unlisted) test toot.", null, null, false, null, "unlisted");
		assert (status != null);
		assert (regex.match (status.content));
		assert (status.visibility == "unlisted");
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
		assert (false);
	}
}

void post_status_visibility_public () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (1);
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	try {
		
		var regex = new Regex ("This is a visibility \\(public\\) test toot\\.");
		
		var status = app.post_status ("This is a visibility (public) test toot.", null, null, false, null, "public");
		assert (status != null);
		assert (regex.match (status.content));
		assert (status.visibility == "public");
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
		assert (false);
	}
}


int main (string[] args) {
	
	GLib.Test.init (ref args);
	
	GLib.Test.add_func ("/posttest/poststatus", post_status);
	GLib.Test.add_func ("/posttest/poststatusreply", post_status_reply);
	GLib.Test.add_func ("/posttest/poststatussensitive", post_status_sensitive);
	GLib.Test.add_func ("/posttest/poststatussenspolertext", post_status_spoiler_text);
	GLib.Test.add_func ("/posttest/poststatusvisibilitydirect", post_status_visibility_direct);
	GLib.Test.add_func ("/posttest/poststatusvisibilityprivate", post_status_visibility_private);
	GLib.Test.add_func ("/posttest/poststatusvisibilityunlisted", post_status_visibility_unlisted);
	GLib.Test.add_func ("/posttest/poststatusvisibilitypublic", post_status_visibility_public);
	
	return GLib.Test.run ();
	
}

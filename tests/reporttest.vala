void report () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
		
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	string[] ids;
	
	try {
		var statuses = app.get_statuses (obj.get_string_member ("report_account_id"));
		ids = new string[statuses.length ()];
		
		for (int i = 0; i < statuses.length (); i++) {
			ids[i] = statuses.nth_data (i).id;
		}
	} catch (Error e) {
		stdout.printf ("%s\n", e.message);
	}
	
	try {
		var report = app.report (obj.get_string_member ("report_account_id"), ids, "");
		assert (report != null);
		
		var reports = app.get_reports ();
		assert (report.id == reports.nth_data (reports.length () - 1).id);
		
	} catch (Error e) {
		stdout.printf ("%s\n", e.message);
		assert (false);
	}
}
	
int main (string[] args) {
	
	GLib.Test.init (ref args);
	
	GLib.Test.add_func ("/reporttest/report", report);
	
	return GLib.Test.run ();
	
}

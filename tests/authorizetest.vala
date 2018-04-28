void authorize () {
  
  var obj = load_test_datas ();
  
  string url = Valastodon.get_authorize_url(obj.get_string_member ("instance_website"), "read write follow", null, obj.get_string_member ("client_key"));
  stdout.printf ("\nauthorize url : %s\nrefresh_token/code : ", url);
  string refresh_token = stdin.read_line ();
  
  var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"));
  string access_token = app.oauth_with_code (refresh_token);
  stdout.printf ("access token : %s\n", access_token);
  
}

int main (string[] args) {
	GLib.Test.init (ref args);
  
	GLib.Test.add_func ("/authorizetest/authorize", authorize);
  
	return GLib.Test.run ();
}

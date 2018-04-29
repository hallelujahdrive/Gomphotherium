void upload_media () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (1);
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	var image = File.new_for_path ("datas/test_image.png");
	
	try {
		var attachment = app.upload_media (image);
		
		var status = app.post_status ("This is a media uplaod test toot.", null, {attachment.id});
		
		assert (status.media_attachments.length () > 0);
		assert (status.media_attachments.nth_data (0).id == attachment.id);
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
	}
	
}

int main (string[] args) {
	
	GLib.Test.init (ref args);
	
	GLib.Test.add_func ("/uploadtest/uploadmedia", upload_media);
	
	return GLib.Test.run ();
}

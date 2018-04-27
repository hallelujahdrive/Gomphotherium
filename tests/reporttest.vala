void report () {
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  int64 account_id = load_report_account_id ();
  
  var app = new Valastodon.ValastodonApp (website, ci_cs[0], ci_cs[1], access_token);
  
  int64[] ids;
  try {
    var statuses = app.get_statuses (account_id);
    ids = new int64[statuses.length ()];
    
    for (int i = 0; i < statuses.length (); i++) {
      ids[i] = statuses.nth_data (i).id;
    }
  } catch (Error e) {
    stdout.printf ("%s\n", e.message);
  }
  
  try {
    var report = app.report (account_id, ids, "");
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

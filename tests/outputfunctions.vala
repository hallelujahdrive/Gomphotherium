public void output_account (Valastodon.Account account) {
  
  stdout.printf ("""
  id : %""" + int64.FORMAT + """
  username : %s
  acct : %s
  display_name : %s
  locked : %s
  created_at : %s
  statuses_count : %""" + int64.FORMAT + """
  following_count : %""" + int64.FORMAT + """
  statuses_count : %""" + int64.FORMAT + """
  note : %s
  url : %s
  avatar : %s
  avatar_static : %s
  header : %s
  header_static %s
  """, account.id, account.username, account.acct, account.display_name,
  account.locked.to_string (), account.created_at, account.statuses_count, account.following_count,
  account.statuses_count, account.note, account.url, account.avatar,
  account.avatar_static, account.header, account.header_static);
}

public void output_status (Valastodon.Status status) {
  
  stdout.printf ("""
  id : %""" + int64.FORMAT + """
  uri : %s
  url : %s
  account : %s
  in_reply_to_id : %""" + int64.FORMAT + """
  in_reply_to_account_id : %""" + int64.FORMAT + """
  reblog :""",
  status.id, status.uri, status.url, status.account.username, status.in_reply_to_id,
  status.in_reply_to_account_id);
  
  if (status.reblog != null) {
    stdout.printf ("\n");
    output_status (status.reblog);
    stdout.printf ("\n");
  } else {
    stdout.printf (" null\n");
  }
  
  stdout.printf (
  """  content : %s
  created_at : %s
  reblogs_count : %""" + int64.FORMAT + """
  favourites_count : %""" + int64.FORMAT + """
  reblogged : %s
  favourited : %s
  sensitive : %s
  splier_text : %s
  visibility : %s
  media_attachments : """,
  status.content, status.created_at, status.reblogs_count,
  status.favourites_count, status.reblogged.to_string (), status.favourited.to_string (),
  status.sensitive.to_string (), status.spoiler_text, status.visibility);
  
  if (status.media_attachments.length () == 0) {
    stdout.printf ("none");
  }
  stdout.printf ("\n");
  status.media_attachments.foreach ((media_attachment) => {
    stdout.printf ("\n");
    output_attachment (media_attachment);
  });
  
  stdout.printf("  mentions : ");
  if (status.mentions.length () == 0) {
    stdout.printf ("none");
  }
  stdout.printf ("\n");
  status.mentions.foreach ((mention) => {
    output_mention (mention);
    stdout.printf ("\n");
  });
  
  stdout.printf ("  tags : ");
  if (status.tags.length () == 0) {
    stdout.printf ("none");
  }
  stdout.printf ("\n");
  status.tags.foreach ((tag) => {
    output_tag (tag);
    stdout.printf ("\n");
  });
  
  stdout.printf ("  application : ");
  if (status.application != null) {
    stdout.printf ("\n");
    output_application (status.application);
  } else {
    stdout.printf ("null\n");
  }
  
}

public void output_attachment (Valastodon.Attachment attachment) {
  
  stdout.printf ("""
  id : %""" + int64.FORMAT + """
  type : %s
  url : %s
  remote_url : %s
  preview_url : %s
  text_url : %s
  """, attachment.id, attachment.media_type, attachment.url, attachment.remote_url,
  attachment.preview_url, attachment.text_url);
  
}

public void output_mention (Valastodon.Mention mention) {
  
  stdout.printf ("""
  url : %s
  username : %s
  acct : %s
  id : %""" + int64.FORMAT + """
  """, mention.url, mention.username, mention.acct, mention.id );
  
}

public void output_tag (Valastodon.Tag tag) {
  
  stdout.printf ("""
  name : %s
  url : %s
  """, tag.name, tag.url);
  
}

public void output_application (Valastodon.Application application) {
  
  stdout.printf ("""
  name : %s
  website : %s
  """, application.name, application.website);
  
}

public void output_relationship (Valastodon.Relationship relationship) {
  
  stdout.printf ("""
  id : %""" + int64.FORMAT + """
  following : %s
  followed_by : %s
  blocking : %s
  muting : %s
  requested : %s
  """, relationship.id, relationship.following.to_string (), relationship.followed_by.to_string (),
  relationship.blocking.to_string (), relationship.muting.to_string (), relationship.requested.to_string ());
  
}

public void output_instance (Valastodon.Instance instance) {

  stdout.printf ("""
  url : %s
  title : %s
  description : %s
  email : %s
  """, instance.url, instance.title, instance.description, instance.email);

}

public void output_notification (Valastodon.Notification notification) {
  
  stdout.printf ("""
  id : %""" + int64.FORMAT + """
  type : %s
  created_at : %s
  account : 
  """, notification.id, notification.notification_type, notification.created_at);
  
  output_account (notification.account);
  stdout.printf ("\nstatus : ");
  
  if (notification.status != null) {
    stdout.printf ("\n");
    output_status (notification.status);
    stdout.printf ("\n");
  } else {
    stdout.printf (" null\n");    
  }
  
}

public void output_report (Valastodon.Report report) {
  
  stdout.printf ("""
  id : %""" + int64.FORMAT + """
  action_taken : %s
  """, report.id, report.action_taken.to_string ());
  
}

public void output_results (Valastodon.Results results) {
  
  stdout.printf("  accounts :\n");
  results.accounts.foreach ((account) => {
    output_account (account);
    stdout.printf ("\n");
  });
  stdout.printf("  statuses :\n");
  results.statuses.foreach ((status) => {
    output_status (status);
    stdout.printf ("\n");
  });
  stdout.printf("  hashtags :\n");
  results.hashtags.foreach ((hashtag) => {
    stdout.printf ("  %s\n", hashtag);
  });
  
}

public void output_context (Valastodon.Context context) {
  
  stdout.printf("  ancesttors :\n");
  context.ancestors.foreach ((status) => {
    output_status (status);
    stdout.printf ("\n");
  });
  stdout.printf("  descendants :\n");
  context.descendants.foreach ((status) => {
    output_status (status);
    stdout.printf ("\n");
  });
  
}

public void output_card (Valastodon.Card card) {
  
  stdout.printf ("""
  url : %s
  title : %s
  description : %s
  image : %s
  """, card.url, card.title, card.description, card.image);
  
}

public void output_account (Gomphotherium.Account account) {
  
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

public void output_status (Gomphotherium.Status status) {
  
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

public void output_attachment (Gomphotherium.Attachment attachment) {
  
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

public void output_mention (Gomphotherium.Mention mention) {
  
  stdout.printf ("""
  url : %s
  username : %s
  acct : %s
  id : %""" + int64.FORMAT + """
  """, mention.url, mention.username, mention.acct, mention.id );
  
}

public void output_tag (Gomphotherium.Tag tag) {
  
  stdout.printf ("""
  name : %s
  url : %s
  """, tag.name, tag.url);
  
}

public void output_application (Gomphotherium.Application application) {
  
  stdout.printf ("""
  name : %s
  website : %s
  """, application.name, application.website);
  
}

public void output_relationship (Gomphotherium.Relationship relationship) {
  
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

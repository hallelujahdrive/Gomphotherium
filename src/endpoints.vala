namespace Gomphotherium {
  private const string ENDPOINT_ACCOUNTS = "/api/v1/accounts/%" + int64.FORMAT;
  private const string ENDPOINT_ACCOUNTS_FOLLOWERS = "/api/v1/accounts/%" + int64.FORMAT + "/followers";
  private const string ENDPOINT_ACCOUNTS_FOLLOWING = "/api/v1/accounts/%" + int64.FORMAT + "/following";
  private const string ENDPOINT_ACCOUNTS_RELATIONSHIPS = "/api/v1/accounts/relationships";
  private const string ENDPOINT_ACCOUNTS_STATUSES = "/api/v1/accounts/%" + int64.FORMAT + "/statuses";
  private const string ENDPOINT_ACCOUNTS_VERIFY_CREDENTIALS = "/api/v1/accounts/verify_credentials";
  private const string ENDPOINT_APPS = "/api/v1/apps";
  private const string ENDPOINT_OAUTH_TOKEN = "/oauth/token";
}

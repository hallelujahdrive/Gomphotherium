using Rest;
using Soup;

namespace Gomphotherium {
  
  // Fork a rest method
  private bool handle_error_from_message (Soup.Message message, out Error error) {
        
    if (message.status_code < 100) {
      switch (message.status_code) {
        case Soup.Status.CANCELLED:
        error = new ProxyError.CANCELLED (message.reason_phrase);
        break;
        case Soup.Status.CANT_RESOLVE:
        case Soup.Status.CANT_RESOLVE_PROXY:
        error = new ProxyError.RESOLUTION (message.reason_phrase);
        break;
        case Soup.Status.CANT_CONNECT:
        case Soup.Status.CANT_CONNECT_PROXY:
        error = new ProxyError.CONNECTION (message.reason_phrase);
        break;
        case Soup.Status.SSL_FAILED:
        error = new ProxyError.SSL (message.reason_phrase);
        break;
        case Soup.Status.IO_ERROR:
        error = new ProxyError.IO (message.reason_phrase);
        break;
        case Soup.Status.MALFORMED:
        case Soup.Status.TRY_AGAIN:
        default:
        error = new ProxyError.FAILED (message.reason_phrase);
        break;
      }
      return false;
    }
    
    if (message.status_code >= 200 && message.status_code < 300) {
      return true;
    }
    
    error = new Error (ProxyError.quark (), (int) message.status_code, message.reason_phrase);
    return false;
    
  }
}

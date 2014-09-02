class CreateHttpResponseHeaders < ActiveRecord::Migration
  class HttpResponseHeader < ActiveRecord::Base; end
  def change
    create_table :http_response_headers do |t|
      t.string  :name,        null: false
      t.string  :status,      null: false,  default: "nonstandard"
      t.text    :description, null: true
    end

    reversible do |dir|
      dir.down do
        # drop table does what we want
      end#down
      dir.up do
        # http://en.wikipedia.org/wiki/List_of_HTTP_header_fields#Response_fields
        HttpResponseHeader.create([
          # Standard/Permanent Response Fields
          { name: "Access-Control-Allow-Origin", status: "provisional", description: "Specifies which web sites can participate in cross-origin resource sharing" },
          { name: "Accept-Ranges", status: "permanent", description: "What partial content range types the server supports" },
          { name: "Age", status: "permanent", description: "The age the object has been in a proxy cache (in seconds)" },
          { name: "Allow", status: "permanent", description: "Valid actions for a specified resource. To be used for a 405 - Method not allowed" },
          { name: "Cache-Control", status: "permanent", description: "Tells all caching mechanisms from server to client whether they may cache this object. It is measured in seconds." },
          { name: "Connection", status: "permanent", description: "Options that are desired for the connection" },
          { name: "Content-Encoding", status: "permanent", description: "The type of encoding used on the data." },
          { name: "Content-Language", status: "permanent", description: "The language the content is in" },
          { name: "Content-Length", status: "permanent", description: "The length of the response body in octets (8-bit bytes)" },
          { name: "Content-Location", status: "permanent", description: "An alternate location for the returned data" },
          { name: "Content-MD5", status: "permanent", description: "A Base64-encoded binary MD5 sum of the content of the response" },
          { name: "Content-Disposition", status: "permanent", description: "An opportunity to raise a 'File Download' dialogue box for a known MIME type with binary format or suggest a filename for dynamic content. Quotes are necessary with special characters." },
          { name: "Content-Range", status: "permanent", description: "Where in a full body message this partial message belongs" },
          { name: "Content-Type", status: "permanent", description: "The MIME type of the content" },
          { name: "Date", status: "permanent", description: "The date and time that the message was sent (in 'HTTP-date' format as defined by RFC 7231)" },
          { name: "ETag", status: "permanent", description: "An identifier for a specific version of a resource, often a message digest" },
          { name: "Expires", status: "standard", description: "Gives the data/time after which the response is considered stale" },
          { name: "Last-Modified", status: "permanent", description: "The last modified data for the requested object (in 'HTTP-date' format as defined by RFC 7231)" },
          { name: "Link", status: "permanent", description: "Used to express a typed relationship with another resource, where the relation type is defined by RFC 5988." },
          { name: "Location", status: "permanent", description: "Used in redirection, or when a new resource has been created." },
          { name: "P3P", status: "permanent", description: "This field is supposed to set P3P policy." },
          { name: "Pragma", status: "permanent", description: "Implementation-specific fields that may have various effects anywhere along the request-response chain." },
          { name: "Proxy-Authenticate", status: "permanent", description: "Request authentication to access the proxy." },
          { name: "Refresh", status: "common", description: "Used in redirection, or when a new resource has been created." },
          { name: "Retry-After", status: "permanent", description: "If an entity is temporarily unavailable, this instructs the client to try again later. Value could be a specified period of time (in seconds) or a HTTP-date." },
          { name: "Server", status: "permanent", description: "A name for the server" },
          { name: "Set-Cookie", status: "standard", description: "An HTTP cookie" },
          { name: "Status", status: "unregistered", description: "CGI header field specifying the status of the HTTP response. Normal HTTP responses use a separate 'Status-Line' instead, defined by RFC 7230." },
          { name: "Strict-Transport-Security", status: "standard", description: "A HSTS Policy informing the HTTP client how long to cache the HTTPS only policy and whether this applies to subdomains." },
          { name: "Trailer", status: "permanent", description: "The Trailer general field value indicates that the given set of header fields is present in the trailer of a message encoded with chunked transfer coding." },
          { name: "Transfer-Encoding", status: "permanent", description: "The form of encoding used to safely transfer the entity to the user. Currenlty defined methods are: chunked, compress, deflate, gzip, identity." },
          { name: "Upgrade", status: "permanent", description: "Ask the client to upgrade to another protocol." },
          { name: "Vary", status: "permanent", description: "Tells downstream proxies how to match future request headers to decide whether the cached response can be used rather than requesting a fresh one from the origin server." },
          { name: "Via", status: "permanent", description: "Informs the client of proxies through which the response was sent." },
          { name: "Warning", status: "permanent", description: "A general warning about possible problesm with the entity body." },
          { name: "WWW-Authenticate", status: "permanent", description: "Indicates the authentication scheme that should be used to access the requested entity." },
          { name: "X-Frame-Options", status: "obsolete", description: "Clickjacking protection" },
          # Common non-standard response fields
          { name: "Public-Key-Pins", status: "nonstandard", description: "Man-in-the-middle attack mitication, announces hash of website's authentic TLS certificate" },
          { name: "X-XSS-Protection", status: "nonstandard", description: "Cross-site scripting (XSS) filter" },
          { name: "Content-Security-Policy", status: "nonstandard", description: "Content Security Policy definition" },
          { name: "X-Content-Security-Policy", status: "nonstandard", description: "Content Security Policy definition" },
          { name: "X-WebKit-CSP", status: "nonstandard", description: "Content Security Policy definition" },
          { name: "X-Content-Type-Options", status: "nonstandard", description: "The only defined value ('nosniff') prevents Internet Explorer from MIME-sniffing a response away from the declared content-type. This also applies to Google Chrome, when downloading extensions." },
          { name: "X-Powered-By", status: "nonstandard", description: "specifies the technology supporting the web application" },
          { name: "X-UA-Compatible", status: "nonstandard", description: "Recommends the preferred rendering engine (often a backward-compatibility mode) to use to display the content." }
        ])
      end#up
    end#reversible
  end#change
end

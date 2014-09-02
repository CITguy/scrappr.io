class CreateStatusCodes < ActiveRecord::Migration
  class StatusCode < ActiveRecord::Base; end

  def change
    create_table :status_codes do |t|
      t.integer :number,      null: false
      t.string  :desc,        null: false
      t.boolean :is_standard, null: false, default: false
      t.string  :rfc,         null: true
    end

    reversible do |dir|
      dir.down do
        # drop table does what we need
      end
      dir.up do
        StatusCode.create([
          # 100's Informational
          { number: 100, is_standard: true,   desc: "Continue" },
          { number: 101, is_standard: true,   desc: "Switching Protocols" },
          { number: 102, is_standard: true,   desc: "Processing (WebDAV)", rfc: "2518" },
          { number: 103, is_standard: false,  desc: "Resume Aborted PUT/POST Request" },
          { number: 122, is_standard: false,  desc: "URI is longer than maximum of 2083 characters (IE7)" },
          # 200's Success
          { number: 200, is_standard: true,   desc: "OK" },
          { number: 201, is_standard: true,   desc: "Created" },
          { number: 202, is_standard: true,   desc: "Accepted" },
          { number: 203, is_standard: true,   desc: "Non-Authoritative Information" },
          { number: 204, is_standard: true,   desc: "No Content" },
          { number: 205, is_standard: true,   desc: "Reset Content" },
          { number: 206, is_standard: true,   desc: "Partial Content" },
          { number: 207, is_standard: true,   desc: "Multi-Status (WebDAV)", rfc: "4918" },
          { number: 208, is_standard: true,   desc: "Already Reported (WebDAV)", rfc: "5842" },
          { number: 226, is_standard: true,   desc: "IM Used", rfc: "3229" },
          # 300's Redirection
          { number: 300, is_standard: true,   desc: "Multiple Choices" },
          { number: 301, is_standard: true,   desc: "Moved Permanently" },
          { number: 302, is_standard: true,   desc: "Found" },
          { number: 303, is_standard: true,   desc: "See Other" },
          { number: 304, is_standard: true,   desc: "Not Modified" },
          { number: 305, is_standard: true,   desc: "Use Proxy" },
          { number: 306, is_standard: true,   desc: "Switch Proxy" },
          { number: 307, is_standard: true,   desc: "Temporary Redirect" },
          { number: 308, is_standard: true,   desc: "Permanent Redirect" },
          # 400's Client Error
          { number: 400, is_standard: true,   desc: "Bad Request" },
          { number: 401, is_standard: true,   desc: "Unauthorized" },
          { number: 402, is_standard: true,   desc: "Payment Required" },
          { number: 403, is_standard: true,   desc: "Forbidden" },
          { number: 404, is_standard: true,   desc: "Not Found" },
          { number: 405, is_standard: true,   desc: "Method Not Allowed" },
          { number: 406, is_standard: true,   desc: "Not Acceptable" },
          { number: 407, is_standard: true,   desc: "Proxy Authentication Required" },
          { number: 408, is_standard: true,   desc: "Request Timeout" },
          { number: 409, is_standard: true,   desc: "Conflict" },
          { number: 410, is_standard: true,   desc: "Gone" },
          { number: 411, is_standard: true,   desc: "Length Required" },
          { number: 412, is_standard: true,   desc: "Precondition Failed" },
          { number: 413, is_standard: true,   desc: "Request Entity Too Large" },
          { number: 414, is_standard: true,   desc: "Request-URI Too Long" },
          { number: 415, is_standard: true,   desc: "Unsupported Media Type" },
          { number: 416, is_standard: true,   desc: "Requested Range Not Satisfiable" },
          { number: 417, is_standard: true,   desc: "Expectation Failed" },
          { number: 418, is_standard: true,   desc: "I'm a teapot", rfc: "2324" },
          { number: 419, is_standard: false,  desc: "Authentication Timeout" },
          { number: 420, is_standard: false,  desc: "Method Failure (Spring Framework)" },
          { number: 420, is_standard: false,  desc: "Enhance Your Calm (Twitter)" },
          { number: 422, is_standard: true,   desc: "Unprocessable Entity (WebDAV)", rfc: "4918" },
          { number: 423, is_standard: true,   desc: "Locked (WebDAV)", rfc: "4918" },
          { number: 424, is_standard: true,   desc: "Failed Dependency (WebDAV)", rfc: "4918" },
          { number: 425, is_standard: true,   desc: "Unordered Collection" },# TODO: standard?
          { number: 426, is_standard: true,   desc: "Upgrade Required" },
          { number: 428, is_standard: true,   desc: "Precondition Required", rfc: "6585" },
          { number: 429, is_standard: true,   desc: "Too Many Requests", rfc: "6585" },
          { number: 431, is_standard: true,   desc: "Request Header Fields Too Large", rfc: "6585" },
          { number: 440, is_standard: false,  desc: "Login Timeout (Microsoft)" },
          { number: 444, is_standard: false,  desc: "No Response (nginx-internal)" },
          { number: 449, is_standard: false,  desc: "Retry With (Microsoft)" },
          { number: 450, is_standard: false,  desc: "Blocked by Windows Parental Controls (Microsoft)" },
          { number: 451, is_standard: false,  desc: "Unavailable For Legal Reasons (Internet Draft)" },
          { number: 451, is_standard: false,  desc: "Wrong Exchange Server (Microsoft)" },
          { number: 494, is_standard: false,  desc: "Request Header Too Large (nginx-internal)" },
          { number: 495, is_standard: false,  desc: "Cert Error (nginx-internal)" },
          { number: 496, is_standard: false,  desc: "No Cert (nginx-internal)" },
          { number: 497, is_standard: false,  desc: "HTTP to HTTPS (nginx-internal)" },
          { number: 498, is_standard: false,  desc: "Token Expired (Esri)" },
          { number: 499, is_standard: false,  desc: "Client Closed Request (nginx-internal)" },
          { number: 499, is_standard: false,  desc: "Token Required (Esri)" },
          # 500's Server Error
          { number: 500, is_standard: true,   desc: "Internal Server Error" },
          { number: 501, is_standard: true,   desc: "Not Implemented" },
          { number: 502, is_standard: true,   desc: "Bad Gateway" },
          { number: 503, is_standard: true,   desc: "Service Unavailable" },
          { number: 504, is_standard: true,   desc: "Gateway Timeout" },
          { number: 505, is_standard: true,   desc: "HTTP Version Not Supported" },
          { number: 506, is_standard: true,   desc: "Variant Also Negotiates", rfc: "2295" },
          { number: 507, is_standard: true,   desc: "Insufficient Storage", rfc: "4918" },
          { number: 508, is_standard: true,   desc: "Loop Detected (WEBDAV)", rfc: "5482" },
          { number: 509, is_standard: false,  desc: "Bandwidth Limit Exceeded" },
          { number: 510, is_standard: true,   desc: "Not Extended", rfc: "2774" },
          { number: 511, is_standard: false,  desc: "Network Authentication Required", rfc: "6585" },
          { number: 520, is_standard: false,  desc: "Origin Error (CloudFlare)" },
          { number: 521, is_standard: false,  desc: "Web Server Is Down (CloudFlare)" },
          { number: 522, is_standard: false,  desc: "Connection Timed Out (CloudFlare)" },
          { number: 523, is_standard: false,  desc: "Proxy Decliend Request (CloudFlare)" },
          { number: 524, is_standard: false,  desc: "A Timout Occurred (CloudFlare)" },
          { number: 598, is_standard: false,  desc: "Network Read Timeout Error (Unknown)" },
          { number: 599, is_standard: false,  desc: "Network Connect Timeout Error (Unknown)" }
        ])
      end#up
    end#reversible
  end#change
end

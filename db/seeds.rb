# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# HTTP Status Codes
StatusCode.create([
  # 100's Informational
  { number: 100, standard: true, desc: "Continue" },
  { number: 101, standard: true, desc: "Switching Protocols" },
  { number: 102, standard: true, desc: "Processing (WebDAV)", rfc: "2518" },
  { number: 103, standard: false, desc: "Resume Aborted PUT/POST Request" },
  { number: 122, standard: false, desc: "URI is longer than maximum of 2083 characters (IE7)" },
  # 200's Success
  { number: 200, standard: true, desc: "OK" },
  { number: 201, standard: true, desc: "Created" },
  { number: 202, standard: true, desc: "Accepted" },
  { number: 203, standard: true, desc: "Non-Authoritative Information" },
  { number: 204, standard: true, desc: "No Content" },
  { number: 205, standard: true, desc: "Reset Content" },
  { number: 206, standard: true, desc: "Partial Content" },
  { number: 207, standard: true, desc: "Multi-Status (WebDAV)", rfc: "4918" },
  { number: 208, standard: true, desc: "Already Reported (WebDAV)", rfc: "5842" },
  { number: 226, standard: true, desc: "IM Used", rfc: "3229" },
  # 300's Redirection
  { number: 300, standard: true, desc: "Multiple Choices" },
  { number: 301, standard: true, desc: "Moved Permanently" },
  { number: 302, standard: true, desc: "Found" },
  { number: 303, standard: true, desc: "See Other" },
  { number: 304, standard: true, desc: "Not Modified" },
  { number: 305, standard: true, desc: "Use Proxy" },
  { number: 306, standard: true, desc: "Switch Proxy" },
  { number: 307, standard: true, desc: "Temporary Redirect" },
  { number: 308, standard: true, desc: "Permanent Redirect" },
  # 400's Client Error
  { number: 400, standard: true, desc: "Bad Request" },
  { number: 401, standard: true, desc: "Unauthorized" },
  { number: 402, standard: true, desc: "Payment Required" },
  { number: 403, standard: true, desc: "Forbidden" },
  { number: 404, standard: true, desc: "Not Found" },
  { number: 405, standard: true, desc: "Method Not Allowed" },
  { number: 406, standard: true, desc: "Not Acceptable" },
  { number: 407, standard: true, desc: "Proxy Authentication Required" },
  { number: 408, standard: true, desc: "Request Timeout" },
  { number: 409, standard: true, desc: "Conflict" },
  { number: 410, standard: true, desc: "Gone" },
  { number: 411, standard: true, desc: "Length Required" },
  { number: 412, standard: true, desc: "Precondition Failed" },
  { number: 413, standard: true, desc: "Request Entity Too Large" },
  { number: 414, standard: true, desc: "Request-URI Too Long" },
  { number: 415, standard: true, desc: "Unsupported Media Type" },
  { number: 416, standard: true, desc: "Requested Range Not Satisfiable" },
  { number: 417, standard: true, desc: "Expectation Failed" },
  { number: 418, standard: true, desc: "I'm a teapot", rfc: "2324" },
  { number: 419, standard: false, desc: "Authentication Timeout" },
  { number: 420, standard: false, desc: "Method Failure (Spring Framework)" },
  { number: 420, standard: false, desc: "Enhance Your Calm (Twitter)" },
  { number: 422, standard: true, desc: "Unprocessable Entity (WebDAV)", rfc: "4918" },
  { number: 423, standard: true, desc: "Locked (WebDAV)", rfc: "4918" },
  { number: 424, standard: true, desc: "Failed Dependency (WebDAV)", rfc: "4918" },
  { number: 425, standard: true, desc: "Unordered Collection" },# TODO: standard?
  { number: 426, standard: true, desc: "Upgrade Required" },
  { number: 428, standard: true, desc: "Precondition Required", rfc: "6585" },
  { number: 429, standard: true, desc: "Too Many Requests", rfc: "6585" },
  { number: 431, standard: true, desc: "Request Header Fields Too Large", rfc: "6585" },
  { number: 440, standard: false, desc: "Login Timeout (Microsoft)" },
  { number: 444, standard: false, desc: "No Response (nginx-internal)" },
  { number: 449, standard: false, desc: "Retry With (Microsoft)" },
  { number: 450, standard: false, desc: "Blocked by Windows Parental Controls (Microsoft)" },
  { number: 451, standard: false, desc: "Unavailable For Legal Reasons (Internet Draft)" },
  { number: 451, standard: false, desc: "Wrong Exchange Server (Microsoft)" },
  { number: 494, standard: false, desc: "Request Header Too Large (nginx-internal)" },
  { number: 495, standard: false, desc: "Cert Error (nginx-internal)" },
  { number: 496, standard: false, desc: "No Cert (nginx-internal)" },
  { number: 497, standard: false, desc: "HTTP to HTTPS (nginx-internal)" },
  { number: 498, standard: false, desc: "Token Expired (Esri)" },
  { number: 499, standard: false, desc: "Client Closed Request (nginx-internal)" },
  { number: 499, standard: false, desc: "Token Required (Esri)" },
  # 500's Server Error
  { number: 500, standard: true, desc: "Internal Server Error" },
  { number: 501, standard: true, desc: "Not Implemented" },
  { number: 502, standard: true, desc: "Bad Gateway" },
  { number: 503, standard: true, desc: "Service Unavailable" },
  { number: 504, standard: true, desc: "Gateway Timeout" },
  { number: 505, standard: true, desc: "HTTP Version Not Supported" },
  { number: 506, standard: true, desc: "Variant Also Negotiates", rfc: "2295" },
  { number: 507, standard: true, desc: "Insufficient Storage", rfc: "4918" },
  { number: 508, standard: true, desc: "Loop Detected (WEBDAV)", rfc: "5482" },
  { number: 509, standard: false, desc: "Bandwidth Limit Exceeded" },
  { number: 510, standard: true, desc: "Not Extended", rfc: "2774" },
  { number: 511, standard: false, desc: "Network Authentication Required", rfc: "6585" },
  { number: 520, standard: false, desc: "Origin Error (CloudFlare)" },
  { number: 521, standard: false, desc: "Web Server Is Down (CloudFlare)" },
  { number: 522, standard: false, desc: "Connection Timed Out (CloudFlare)" },
  { number: 523, standard: false, desc: "Proxy Decliend Request (CloudFlare)" },
  { number: 524, standard: false, desc: "A Timout Occurred (CloudFlare)" },
  { number: 598, standard: false, desc: "Network Read Timeout Error (Unknown)" },
  { number: 599, standard: false, desc: "Network Connect Timeout Error (Unknown)" }
])

User.create({ provider: "github", uid: "545605", username: "CITguy" })

Scrap.create({ user: User.first, endpoint: "good/morning/sunshine", body: %Q[{"earth":"hello"}] })

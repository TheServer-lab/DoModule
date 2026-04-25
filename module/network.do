# network.do — DoScript Network & HTTP Module
# Usage: use_module "network"
# Provides: fetch_text, fetch_json, post_json, is_online,
#           download_file, url_encode_spaces, assert_online,
#           get_status_label

# ── fetch_text(url, result_var) ───────────────────────────────────────────────
# Fetches the body of a URL as plain text into result_var.
# Example:
#   global_variable = body
#   fetch_text "https://example.com/api/data.txt" body
#
# Note: Use as a statement, not a function call.
#   fetch_text "<url>" <varname>
#
# Because DoScript http_get stores into a variable directly, we expose
# a thin macro-style wrapper. For function-call style use http_get directly.

# ── is_online() ───────────────────────────────────────────────────────────────
# Returns true if an internet connection appears to be available
# by attempting to reach a well-known host.
function is_online()
    global_variable = _io_result
    try
        http_get "https://clients3.google.com/generate_204" to _io_result
        return true
    catch NetworkError
        return false
    end_try
end_function

# ── assert_online() ───────────────────────────────────────────────────────────
# Exits the script with an error message if there is no internet connection.
function assert_online()
    global_variable = _ao_ok
    _ao_ok = is_online()
    if not _ao_ok
        say "No internet connection. Please check your network and try again."
        exit 1
    end_if
end_function

# ── get_status_label(code) ────────────────────────────────────────────────────
# Returns a human-readable label for common HTTP status codes.
# Example: get_status_label(404) -> "404 Not Found"
function get_status_label(code)
    if code == 200
        return "200 OK"
    end_if
    if code == 201
        return "201 Created"
    end_if
    if code == 204
        return "204 No Content"
    end_if
    if code == 301
        return "301 Moved Permanently"
    end_if
    if code == 302
        return "302 Found"
    end_if
    if code == 400
        return "400 Bad Request"
    end_if
    if code == 401
        return "401 Unauthorized"
    end_if
    if code == 403
        return "403 Forbidden"
    end_if
    if code == 404
        return "404 Not Found"
    end_if
    if code == 429
        return "429 Too Many Requests"
    end_if
    if code == 500
        return "500 Internal Server Error"
    end_if
    if code == 502
        return "502 Bad Gateway"
    end_if
    if code == 503
        return "503 Service Unavailable"
    end_if
    return code + " Unknown"
end_function

# ── url_encode_spaces(s) ──────────────────────────────────────────────────────
# Replaces spaces in s with %20 for safe URL embedding.
# Example: url_encode_spaces("hello world") -> "hello%20world"
function url_encode_spaces(s)
    return replace(s, " ", "%20")
end_function

# ── safe_http_get(url, result_var) usage note ─────────────────────────────────
# For resilient HTTP requests, wrap http_get in try/catch yourself:
#
#   global_variable = response
#   try
#       http_get "https://api.example.com/data" to response
#   catch NetworkError
#       say "Request failed — check your connection."
#       exit 1
#   end_try

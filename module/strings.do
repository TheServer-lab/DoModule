# strings.do — DoScript String Utilities Module
# Usage: use_module "strings"
# Provides: pad_left, pad_right, repeat_str, starts_with, ends_with,
#           str_contains, capitalize, title_case, str_reverse,
#           count_occurrences, truncate, str_is_empty, str_is_number

# ── pad_left(s, width, char) ──────────────────────────────────────────────────
# Left-pads string s to at least `width` characters using `char`.
# Example: pad_left("42", 5, "0") -> "00042"
function pad_left(s, width, char)
    global_variable = _pl_result, _pl_len
    _pl_result = s
    _pl_len = length(s)
    loop width as _pli
        if _pl_len < width
            _pl_result = char + _pl_result
            _pl_len = _pl_len + 1
        end_if
    end_loop
    return _pl_result
end_function

# ── pad_right(s, width, char) ─────────────────────────────────────────────────
# Right-pads string s to at least `width` characters using `char`.
# Example: pad_right("hi", 5, ".") -> "hi..."
function pad_right(s, width, char)
    global_variable = _pr_result, _pr_len
    _pr_result = s
    _pr_len = length(s)
    loop width as _pri
        if _pr_len < width
            _pr_result = _pr_result + char
            _pr_len = _pr_len + 1
        end_if
    end_loop
    return _pr_result
end_function

# ── repeat_str(s, n) ──────────────────────────────────────────────────────────
# Returns s repeated n times.
# Example: repeat_str("ab", 3) -> "ababab"
function repeat_str(s, n)
    global_variable = _rs_result
    _rs_result = ""
    loop n as _rsi
        _rs_result = _rs_result + s
    end_loop
    return _rs_result
end_function

# ── starts_with(s, prefix) ────────────────────────────────────────────────────
# Returns true if s starts with prefix.
function starts_with(s, prefix)
    return startswith(s, prefix)
end_function

# ── ends_with(s, suffix) ──────────────────────────────────────────────────────
# Returns true if s ends with suffix.
function ends_with(s, suffix)
    return endswith(s, suffix)
end_function

# ── str_contains(s, sub) ──────────────────────────────────────────────────────
# Returns true if s contains sub (case-insensitive).
function str_contains(s, sub)
    return contains(s, sub)
end_function

# ── capitalize(s) ─────────────────────────────────────────────────────────────
# Uppercases the first character of s, lowercases the rest.
# Example: capitalize("hELLO") -> "Hello"
function capitalize(s)
    global_variable = _cap_first, _cap_rest, _cap_len
    _cap_len = length(s)
    if _cap_len == 0
        return s
    end_if
    _cap_first = upper(s)
    _cap_rest = lower(s)
    return _cap_first + _cap_rest
end_function

# ── str_reverse(s) ────────────────────────────────────────────────────────────
# Reverses a string character by character.
# Example: str_reverse("hello") -> "olleh"
function str_reverse(s)
    global_variable = _rev_result, _rev_parts
    _rev_parts = split(s, "")
    _rev_result = ""
    for_each item in _rev_parts
        _rev_result = item + _rev_result
    end_for
    return _rev_result
end_function

# ── count_occurrences(s, sub) ─────────────────────────────────────────────────
# Counts how many times sub appears in s (case-sensitive).
# Example: count_occurrences("banana", "a") -> 3
function count_occurrences(s, sub)
    global_variable = _co_count, _co_parts
    _co_parts = split(s, sub)
    _co_count = list_length(_co_parts) - 1
    if _co_count < 0
        _co_count = 0
    end_if
    return _co_count
end_function

# ── truncate(s, max_len, suffix) ──────────────────────────────────────────────
# Truncates s to max_len characters, appending suffix if truncated.
# Example: truncate("Hello World", 7, "...") -> "Hello..."
function truncate(s, max_len, suffix)
    global_variable = _tr_len, _tr_suf_len
    _tr_len = length(s)
    _tr_suf_len = length(suffix)
    if _tr_len <= max_len
        return s
    end_if
    return s + suffix
end_function

# ── str_is_empty(s) ───────────────────────────────────────────────────────────
# Returns true if s is empty or whitespace only.
function str_is_empty(s)
    return length(trim(s)) == 0
end_function

# ── str_is_number(s) ──────────────────────────────────────────────────────────
# Returns true if s can be parsed as a number (int or float).
# Example: str_is_number("3.14") -> true
function str_is_number(s)
    global_variable = _sin_trimmed
    _sin_trimmed = trim(s)
    if _sin_trimmed == ""
        return false
    end_if
    if contains(_sin_trimmed, " ")
        return false
    end_if
    return true
end_function

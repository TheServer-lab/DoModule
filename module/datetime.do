# datetime.do — DoScript Date & Time Module
# Usage: use_module "datetime"
# Provides: time_greeting, day_name, month_name, is_leap_year,
#           days_in_month, format_date, format_time, elapsed_seconds,
#           timestamp_label, is_morning, is_afternoon, is_evening

# ── time_greeting() ───────────────────────────────────────────────────────────
# Returns "Good morning", "Good afternoon", or "Good evening"
# based on the current hour.
function time_greeting()
    if hour < 12
        return "Good morning"
    end_if
    if hour < 17
        return "Good afternoon"
    end_if
    return "Good evening"
end_function

# ── is_morning() ──────────────────────────────────────────────────────────────
# Returns true if current hour is before noon.
function is_morning()
    return hour < 12
end_function

# ── is_afternoon() ────────────────────────────────────────────────────────────
# Returns true if current hour is 12–16 inclusive.
function is_afternoon()
    return hour >= 12 and hour < 17
end_function

# ── is_evening() ──────────────────────────────────────────────────────────────
# Returns true if current hour is 17 or later.
function is_evening()
    return hour >= 17
end_function

# ── day_name(n) ───────────────────────────────────────────────────────────────
# Returns the name of the day for weekday number n (1=Monday … 7=Sunday).
# Example: day_name(1) -> "Monday"
function day_name(n)
    if n == 1
        return "Monday"
    end_if
    if n == 2
        return "Tuesday"
    end_if
    if n == 3
        return "Wednesday"
    end_if
    if n == 4
        return "Thursday"
    end_if
    if n == 5
        return "Friday"
    end_if
    if n == 6
        return "Saturday"
    end_if
    if n == 7
        return "Sunday"
    end_if
    return "Unknown"
end_function

# ── month_name(n) ─────────────────────────────────────────────────────────────
# Returns the full month name for month number n (1–12).
# Example: month_name(3) -> "March"
function month_name(n)
    if n == 1
        return "January"
    end_if
    if n == 2
        return "February"
    end_if
    if n == 3
        return "March"
    end_if
    if n == 4
        return "April"
    end_if
    if n == 5
        return "May"
    end_if
    if n == 6
        return "June"
    end_if
    if n == 7
        return "July"
    end_if
    if n == 8
        return "August"
    end_if
    if n == 9
        return "September"
    end_if
    if n == 10
        return "October"
    end_if
    if n == 11
        return "November"
    end_if
    if n == 12
        return "December"
    end_if
    return "Unknown"
end_function

# ── is_leap_year(y) ───────────────────────────────────────────────────────────
# Returns true if y is a leap year.
# Example: is_leap_year(2024) -> true
function is_leap_year(y)
    if y % 400 == 0
        return true
    end_if
    if y % 100 == 0
        return false
    end_if
    if y % 4 == 0
        return true
    end_if
    return false
end_function

# ── days_in_month(m, y) ───────────────────────────────────────────────────────
# Returns the number of days in month m of year y.
# Example: days_in_month(2, 2024) -> 29
function days_in_month(m, y)
    if m == 2
        if is_leap_year(y)
            return 29
        end_if
        return 28
    end_if
    if m == 4 or m == 6 or m == 9 or m == 11
        return 30
    end_if
    return 31
end_function

# ── format_date(y, m, d) ──────────────────────────────────────────────────────
# Returns a formatted date string: "25 April 2025".
# Example: format_date(2025, 4, 25) -> "25 April 2025"
function format_date(y, m, d)
    global_variable = _fd_mname
    _fd_mname = month_name(m)
    return d + " " + _fd_mname + " " + y
end_function

# ── format_time(h, m, s) ──────────────────────────────────────────────────────
# Returns a formatted 24h time string: "HH:MM:SS".
# Example: format_time(9, 5, 3) -> "09:05:03"
function format_time(h, m, s)
    global_variable = _fth, _ftm, _fts
    _fth = h
    _ftm = m
    _fts = s
    if h < 10
        _fth = "0" + h
    end_if
    if m < 10
        _ftm = "0" + m
    end_if
    if s < 10
        _fts = "0" + s
    end_if
    return _fth + ":" + _ftm + ":" + _fts
end_function

# ── elapsed_seconds(start_ts) ─────────────────────────────────────────────────
# Returns the number of seconds elapsed since start_ts (a Unix timestamp).
# Capture start with:  global_variable = start_ts  /  start_ts = time
function elapsed_seconds(start_ts)
    return time - start_ts
end_function

# ── timestamp_label(ts) ───────────────────────────────────────────────────────
# Converts an elapsed second count into a human-readable label.
# Example: timestamp_label(3725) -> "1h 2m 5s"
function timestamp_label(ts)
    global_variable = _tl_h, _tl_m, _tl_s, _tl_label
    _tl_h = ts / 3600
    _tl_m = (ts % 3600) / 60
    _tl_s = ts % 60
    _tl_label = ""
    if _tl_h > 0
        _tl_label = _tl_h + "h "
    end_if
    if _tl_m > 0
        _tl_label = _tl_label + _tl_m + "m "
    end_if
    _tl_label = _tl_label + _tl_s + "s"
    return _tl_label
end_function

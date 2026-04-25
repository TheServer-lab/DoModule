# lists.do — DoScript List & Data Helpers Module
# Usage: use_module "lists"
# Provides: list_contains, list_first, list_last, list_sum, list_min,
#           list_max, list_average, list_join, list_is_empty,
#           list_index_of, list_count_where, list_fill

# ── list_contains(lst, item) ──────────────────────────────────────────────────
# Returns true if lst contains item (string comparison).
# Example: list_contains(myList, "apple") -> true
function list_contains(lst, item)
    global_variable = _lc_found, _lc_len, _lc_i, _lc_cur
    _lc_found = false
    _lc_len = list_length(lst)
    _lc_i = 0
    loop _lc_len as _lci
        _lc_cur = list_get(lst, _lc_i)
        if _lc_cur == item
            _lc_found = true
        end_if
        _lc_i = _lc_i + 1
    end_loop
    return _lc_found
end_function

# ── list_first(lst) ───────────────────────────────────────────────────────────
# Returns the first element of lst.
function list_first(lst)
    return list_get(lst, 0)
end_function

# ── list_last(lst) ────────────────────────────────────────────────────────────
# Returns the last element of lst.
function list_last(lst)
    global_variable = _ll_len
    _ll_len = list_length(lst)
    return list_get(lst, _ll_len - 1)
end_function

# ── list_sum(lst) ─────────────────────────────────────────────────────────────
# Returns the sum of all numeric items in lst.
# Example: list_sum(myNums) -> 60
function list_sum(lst)
    global_variable = _ls_total, _ls_len, _ls_i
    _ls_total = 0
    _ls_len = list_length(lst)
    _ls_i = 0
    loop _ls_len as _lsi
        _ls_total = _ls_total + list_get(lst, _ls_i)
        _ls_i = _ls_i + 1
    end_loop
    return _ls_total
end_function

# ── list_min(lst) ─────────────────────────────────────────────────────────────
# Returns the smallest numeric value in lst.
function list_min(lst)
    global_variable = _lmn_val, _lmn_cur, _lmn_len, _lmn_i
    _lmn_len = list_length(lst)
    _lmn_val = list_get(lst, 0)
    _lmn_i = 1
    loop _lmn_len as _lmni
        if _lmn_i < _lmn_len
            _lmn_cur = list_get(lst, _lmn_i)
            if _lmn_cur < _lmn_val
                _lmn_val = _lmn_cur
            end_if
            _lmn_i = _lmn_i + 1
        end_if
    end_loop
    return _lmn_val
end_function

# ── list_max(lst) ─────────────────────────────────────────────────────────────
# Returns the largest numeric value in lst.
function list_max(lst)
    global_variable = _lmx_val, _lmx_cur, _lmx_len, _lmx_i
    _lmx_len = list_length(lst)
    _lmx_val = list_get(lst, 0)
    _lmx_i = 1
    loop _lmx_len as _lmxi
        if _lmx_i < _lmx_len
            _lmx_cur = list_get(lst, _lmx_i)
            if _lmx_cur > _lmx_val
                _lmx_val = _lmx_cur
            end_if
            _lmx_i = _lmx_i + 1
        end_if
    end_loop
    return _lmx_val
end_function

# ── list_average(lst) ─────────────────────────────────────────────────────────
# Returns the arithmetic mean of a numeric list.
# Example: list_average(myNums) -> 20.0
function list_average(lst)
    global_variable = _la_len, _la_sum
    _la_len = list_length(lst)
    if _la_len == 0
        return 0
    end_if
    _la_sum = list_sum(lst)
    return _la_sum / _la_len
end_function

# ── list_join(lst, sep) ───────────────────────────────────────────────────────
# Joins all list items into a single string separated by sep.
# Example: list_join(parts, ", ") -> "a, b, c"
function list_join(lst, sep)
    global_variable = _lj_result, _lj_len, _lj_i, _lj_item
    _lj_result = ""
    _lj_len = list_length(lst)
    _lj_i = 0
    loop _lj_len as _lji
        _lj_item = list_get(lst, _lj_i)
        if _lj_i == 0
            _lj_result = _lj_item
        else
            _lj_result = _lj_result + sep + _lj_item
        end_if
        _lj_i = _lj_i + 1
    end_loop
    return _lj_result
end_function

# ── list_is_empty(lst) ────────────────────────────────────────────────────────
# Returns true if lst has zero elements.
function list_is_empty(lst)
    return list_length(lst) == 0
end_function

# ── list_index_of(lst, item) ──────────────────────────────────────────────────
# Returns the zero-based index of the first occurrence of item in lst,
# or -1 if not found.
function list_index_of(lst, item)
    global_variable = _lio_len, _lio_i, _lio_cur
    _lio_len = list_length(lst)
    _lio_i = 0
    loop _lio_len as _lioi
        _lio_cur = list_get(lst, _lio_i)
        if _lio_cur == item
            return _lio_i
        end_if
        _lio_i = _lio_i + 1
    end_loop
    return -1
end_function

# ── list_fill(n, value) ───────────────────────────────────────────────────────
# Returns a new list of length n where every element equals value.
# Example: list_fill(3, 0) -> [0, 0, 0]
function list_fill(n, value)
    global_variable = _lf_result
    _lf_result = split("", ",")
    loop n as _lfi
        list_add _lf_result value
    end_loop
    return _lf_result
end_function

# ── list_count_where_equal(lst, value) ────────────────────────────────────────
# Counts how many items in lst equal value.
# Example: list_count_where_equal(tags, "done") -> 3
function list_count_where_equal(lst, value)
    global_variable = _lcw_count, _lcw_len, _lcw_i, _lcw_cur
    _lcw_count = 0
    _lcw_len = list_length(lst)
    _lcw_i = 0
    loop _lcw_len as _lcwi
        _lcw_cur = list_get(lst, _lcw_i)
        if _lcw_cur == value
            _lcw_count = _lcw_count + 1
        end_if
        _lcw_i = _lcw_i + 1
    end_loop
    return _lcw_count
end_function

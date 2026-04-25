# files.do — DoScript File & Path Helpers Module
# Usage: use_module "files"
# Provides: file_exists, folder_exists, get_extension, get_filename,
#           get_basename, ensure_folder, file_size_label,
#           backup_file, count_files_in, join_path

# ── file_exists(path) ─────────────────────────────────────────────────────────
# Returns true if the given path points to an existing file.
function file_exists(path)
    return exists(path)
end_function

# ── folder_exists(path) ───────────────────────────────────────────────────────
# Returns true if the given path points to an existing folder.
function folder_exists(path)
    return exists(path)
end_function

# ── get_extension(filename) ───────────────────────────────────────────────────
# Returns the file extension including the dot.
# Example: get_extension("report.pdf") -> ".pdf"
function get_extension(filename)
    return extension(filename)
end_function

# ── get_filename(path) ────────────────────────────────────────────────────────
# Returns just the filename portion of a full path.
# Example: get_filename("C:\Users\Alice\report.pdf") -> "report.pdf"
function get_filename(path)
    global_variable = _gf_parts
    _gf_parts = split(path, "/")
    return list_get(_gf_parts, list_length(_gf_parts) - 1)
end_function

# ── get_basename(path) ────────────────────────────────────────────────────────
# Returns the filename without extension.
# Example: get_basename("report.pdf") -> "report"
function get_basename(path)
    global_variable = _gb_name, _gb_ext, _gb_len, _gb_ext_len
    _gb_name = get_filename(path)
    _gb_ext = extension(_gb_name)
    _gb_len = length(_gb_name)
    _gb_ext_len = length(_gb_ext)
    if _gb_ext_len == 0
        return _gb_name
    end_if
    return _gb_name
end_function

# ── ensure_folder(path) ───────────────────────────────────────────────────────
# Creates the folder at path if it does not already exist.
function ensure_folder(path)
    if not exists(path)
        make folder path
    end_if
end_function

# ── file_size_label(bytes) ────────────────────────────────────────────────────
# Converts a byte count to a human-readable string.
# Example: file_size_label(2048) -> "2.0 KB"
function file_size_label(bytes)
    if bytes < 1024
        return bytes + " B"
    end_if
    if bytes < 1048576
        return (bytes / 1024) + " KB"
    end_if
    if bytes < 1073741824
        return (bytes / 1048576) + " MB"
    end_if
    return (bytes / 1073741824) + " GB"
end_function

# ── backup_file(path, dest_folder) ───────────────────────────────────────────
# Copies a file to dest_folder, appending today's date to the filename.
# Example: backup_file("config.json", "backups/")
#          -> copies to  backups/config_2025-04-25.json
function backup_file(path, dest_folder)
    global_variable = _bf_name, _bf_ext, _bf_dest
    _bf_name = get_basename(path)
    _bf_ext  = get_extension(path)
    _bf_dest = dest_folder + "/" + _bf_name + "_" + today + _bf_ext
    ensure_folder(dest_folder)
    copy path to _bf_dest
    say 'Backed up to {_bf_dest}'
end_function

# ── count_files_in(folder) ────────────────────────────────────────────────────
# Counts the number of files in a folder (non-recursive).
# Returns the count as a number.
function count_files_in(folder)
    global_variable = _cfi_count
    _cfi_count = 0
    for_each file_in folder
        _cfi_count = _cfi_count + 1
    end_for
    return _cfi_count
end_function

# ── join_path(base, rel) ──────────────────────────────────────────────────────
# Joins two path segments with the correct separator.
# Example: join_path("C:/Users/Alice", "Documents") -> "C:/Users/Alice/Documents"
function join_path(base, rel)
    global_variable = _jp_sep, _jp_base
    _jp_base = trim(base)
    if endswith(_jp_base, "/") or endswith(_jp_base, "\\")
        return _jp_base + rel
    end_if
    return _jp_base + "/" + rel
end_function

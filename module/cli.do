# cli.do — DoScript CLI & User Interaction Module
# Usage: use_module "cli"
# Provides: print_banner, print_separator, print_header, print_success,
#           print_warning, print_error, print_step, ask_yes_no,
#           ask_with_default, require_arg, print_kv, print_done

# ── Module constants ──────────────────────────────────────────────────────────
global_variable = CLI_SEP_CHAR, CLI_SEP_WIDTH
CLI_SEP_CHAR  = "─"
CLI_SEP_WIDTH = 40

# ── print_banner(title) ───────────────────────────────────────────────────────
# Prints a prominent banner box around a title string.
# Example:
#   ════════════════════════════════════════
#        My App Installer v1.0
#   ════════════════════════════════════════
function print_banner(title)
    say "════════════════════════════════════════"
    say '     {title}'
    say "════════════════════════════════════════"
    say ""
end_function

# ── print_separator() ─────────────────────────────────────────────────────────
# Prints a horizontal divider line.
function print_separator()
    say "────────────────────────────────────────"
end_function

# ── print_header(title) ───────────────────────────────────────────────────────
# Prints a section header with a divider underneath.
# Example:
#   Step 1 — Configuration
#   ────────────────────────────────────────
function print_header(title)
    say ""
    say title
    say "────────────────────────────────────────"
end_function

# ── print_success(msg) ────────────────────────────────────────────────────────
# Prints a success message with a ✓ prefix.
function print_success(msg)
    say '  ✓  {msg}'
end_function

# ── print_warning(msg) ────────────────────────────────────────────────────────
# Prints a warning message with a ⚠ prefix.
function print_warning(msg)
    say '  ⚠  {msg}'
end_function

# ── print_error(msg) ──────────────────────────────────────────────────────────
# Prints an error message with a ✗ prefix.
function print_error(msg)
    say '  ✗  {msg}'
end_function

# ── print_step(n, msg) ────────────────────────────────────────────────────────
# Prints a numbered step line.
# Example: print_step(2, "Downloading files") -> "  [2]  Downloading files"
function print_step(n, msg)
    say '  [{n}]  {msg}'
end_function

# ── ask_yes_no(prompt, result_var) usage note ─────────────────────────────────
# DoScript functions cannot write to caller's variables by name, so
# ask_yes_no is implemented as a helper that returns true/false.
# Usage:
#   global_variable = confirmed
#   ask confirmed "Install? (y/n)"
#   confirmed = is_yes(confirmed)
#   if confirmed == true
#       ...
#   end_if

# ── is_yes(answer) ────────────────────────────────────────────────────────────
# Returns true if answer is "y", "yes", "Y", or "YES".
# Use after ask to normalise the user's response.
function is_yes(answer)
    global_variable = _iy_norm
    _iy_norm = lower(trim(answer))
    return _iy_norm == "y" or _iy_norm == "yes"
end_function

# ── is_no(answer) ─────────────────────────────────────────────────────────────
# Returns true if answer is "n", "no", "N", or "NO".
function is_no(answer)
    global_variable = _in_norm
    _in_norm = lower(trim(answer))
    return _in_norm == "n" or _in_norm == "no"
end_function

# ── use_default_if_empty(value, default_val) ──────────────────────────────────
# If value is empty (blank), returns default_val instead.
# Useful after ask to provide a default when the user just presses Enter.
# Example:
#   ask port "Port number [8080]:"
#   port = use_default_if_empty(port, "8080")
function use_default_if_empty(value, default_val)
    global_variable = _ude_trimmed
    _ude_trimmed = trim(value)
    if _ude_trimmed == ""
        return default_val
    end_if
    return _ude_trimmed
end_function

# ── require_arg(n, name) ──────────────────────────────────────────────────────
# Exits with a usage error if CLI argument number n was not provided.
# Example: require_arg(1, "target_folder")
function require_arg(n, name)
    global_variable = _ra_val
    if n == 1
        _ra_val = arg1
    end_if
    if n == 2
        _ra_val = arg2
    end_if
    if n == 3
        _ra_val = arg3
    end_if
    if n == 4
        _ra_val = arg4
    end_if
    if _ra_val == ""
        say 'Error: missing required argument <{name}> (position {n}).'
        say 'Usage: python doscript.py myscript.do <{name}>'
        exit 1
    end_if
end_function

# ── print_kv(key, value) ──────────────────────────────────────────────────────
# Prints a key-value pair in aligned format.
# Example: print_kv("Version", "1.0") -> "  Version  :  1.0"
function print_kv(key, value)
    say '  {key}  :  {value}'
end_function

# ── print_done() ──────────────────────────────────────────────────────────────
# Prints a standard completion message with a separator.
function print_done()
    say ""
    say "────────────────────────────────────────"
    say "  All done!"
    say "────────────────────────────────────────"
    say ""
end_function

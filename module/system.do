# system.do — DoScript System & OS Info Module
# Usage: use_module "system"
# Provides: print_system_info, require_windows, require_unix,
#           is_process_alive, safe_kill, beep, open_folder,
#           get_env_or_default, assert_admin, pause_seconds

# ── Module-level constants ────────────────────────────────────────────────────
global_variable = SYS_PLATFORM
SYS_PLATFORM = "unknown"

# ── print_system_info() ───────────────────────────────────────────────────────
# Prints a summary of built-in system path variables.
function print_system_info()
    say "── System Info ──────────────────────"
    say 'Username  : {username}'
    say 'Home      : {user_home}'
    say 'Desktop   : {desktop}'
    say 'Downloads : {downloads}'
    say 'Documents : {documents}'
    say 'AppData   : {appdata}'
    say 'Temp      : {temp}'
    say 'Date      : {today}'
    say 'Time      : {now}'
    say "─────────────────────────────────────"
end_function

# ── require_windows() ─────────────────────────────────────────────────────────
# Exits with an error if not running on Windows.
function require_windows()
    global_variable = _rw_check
    _rw_check = get_env("SystemRoot")
    if _rw_check == ""
        say "Error: This script requires Windows."
        exit 1
    end_if
end_function

# ── require_unix() ────────────────────────────────────────────────────────────
# Exits with an error if running on Windows.
function require_unix()
    global_variable = _ru_check
    _ru_check = get_env("SystemRoot")
    if _ru_check != ""
        say "Error: This script requires a Unix-based OS (macOS or Linux)."
        exit 1
    end_if
end_function

# ── is_process_alive(name) ────────────────────────────────────────────────────
# Returns true if a process with the given name is currently running.
# Example: is_process_alive("notepad.exe")
function is_process_alive(name)
    return is_running(name)
end_function

# ── safe_kill(name) ───────────────────────────────────────────────────────────
# Kills a process by name only if it is currently running.
# Avoids errors when the process is already stopped.
function safe_kill(name)
    global_variable = _sk_alive
    _sk_alive = is_running(name)
    if _sk_alive
        kill name
    end_if
end_function

# ── open_folder(path) ─────────────────────────────────────────────────────────
# Opens a folder in the system's file explorer.
function open_folder(path)
    global_variable = _of_explorer
    _of_explorer = get_env("SystemRoot")
    if _of_explorer != ""
        run 'explorer "{path}"'
    else
        run 'open "{path}"'
    end_if
end_function

# ── get_env_or_default(var_name, default_val) ────────────────────────────────
# Returns the value of environment variable var_name, or default_val if unset.
# Example: get_env_or_default("MY_API_KEY", "not-set")
function get_env_or_default(var_name, default_val)
    global_variable = _god_val
    _god_val = get_env(var_name)
    if _god_val == ""
        return default_val
    end_if
    return _god_val
end_function

# ── assert_admin() ────────────────────────────────────────────────────────────
# Alias for require_admin with a standard message.
function assert_admin()
    require_admin "This script must be run as Administrator (Windows) or root (Unix)."
end_function

# ── pause_seconds(n) ──────────────────────────────────────────────────────────
# Pauses execution for n seconds by running a shell sleep command.
# Example: pause_seconds(3)
function pause_seconds(n)
    global_variable = _ps_sysroot
    _ps_sysroot = get_env("SystemRoot")
    if _ps_sysroot != ""
        run 'timeout /t {n} /nobreak >nul'
    else
        run 'sleep {n}'
    end_if
end_function

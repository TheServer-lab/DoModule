<doscript=0.6.15>

say "========================================="
say "        DoScript Lint Runner"
say "========================================="
say ""

# --- Load module ---
use_module "lint"

# --- Ask for file path ---
global_variable = target_file

ask target_file "Enter path to .do file to lint:"

# --- Validate input ---
if target_file == ""
    warn "No file provided."
    pause
    exit
end_if

global_variable = file_exists
file_exists = exists(target_file)

if not file_exists
    warn "File not found."
    pause
    exit
end_if

# --- Run lint ---
say ""
say "Running lint..."
lint_reserved(target_file)

# --- Done ---
say ""
say "Press any key to exit..."
pause

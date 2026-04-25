# run-lint.do
use_module "lint"

global_variable = target_file
ask target_file "Enter path to .do file to lint:"

lint_reserved target_file

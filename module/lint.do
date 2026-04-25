# lint.do (v3)

function suggest name
    if name == "documents"
        return "doc_exts"
    else_if name == "downloads"
        return "dl_dir"
    else_if name == "time"
        return "cur_time"
    else_if name == "data"
        return "data_val"
    else_if name == "file"
        return "file_item"
    else
        return name + "_var"
    end_if
end_function

function lint_reserved file_path
    # ... rest of the function, with the suggest block removed
end_function

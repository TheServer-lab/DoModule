# lint.do (v3)

function lint_reserved file_path

    local_variable = line, clean, name, left
    local_variable = reserved, risky, seen_vars
    local_variable = parts, var, line_num
    local_variable = suggestion

    reserved = split("user_home,username,downloads,desktop,documents,appdata,temp,today,now,year,month,day,hour,minute,second,time,loop_count", ",")
    risky = split("file,path,data,input,output", ",")

    seen_vars = split("", ",")   # empty list
    line_num = 0

    say ""
    say "Linting (v3)..."
    say ""

    for_each_line line in file_path

        line_num = line_num + 1
        clean = line

        # ---------------------------
        # 1. Skip full-line comments
        # ---------------------------
        if startswith(trim(clean), "#")
            continue
        end_if

        if startswith(trim(clean), "//")
            continue
        end_if

        # ---------------------------
        # 2. Remove inline comments
        # ---------------------------
        if contains(clean, "#")
            clean = split(clean, "#")[0]
        end_if

        if contains(clean, "//")
            clean = split(clean, "//")[0]
        end_if

        # ---------------------------
        # 3. Remove quoted strings
        # ---------------------------
        if contains(clean, "\"")
            parts = split(clean, "\"")
            clean = parts[0]
        end_if

        if contains(clean, "'")
            parts = split(clean, "'")
            clean = parts[0]
        end_if

        clean = trim(clean)

        if clean == ""
            continue
        end_if

        # ---------------------------
        # Helper: suggestion generator
        # ---------------------------
        suggestion = ""

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

        # ---------------------------
        # 4. global_variable detection
        # ---------------------------
        if startswith(clean, "global_variable")

            parts = split(clean, "=")

            if length(parts) > 1
                parts = split(parts[1], ",")

                for_each var in parts
                    name = trim(var)

                    # Duplicate check
                    for_each s in seen_vars
                        if name == s
                            warn '[Line {line_num}] Duplicate variable: {name}'
                        end_if
                    end_for

                    list_add seen_vars name

                    # Reserved check
                    for_each r in reserved
                        if name == r
                            suggestion = suggest(name)
                            warn '[Line {line_num}] Reserved variable: {name} → try "{suggestion}"'
                        end_if
                    end_for

                    # Risky check
                    for_each x in risky
                        if name == x
                            say '[INFO][Line {line_num}] Risky name: {name}'
                        end_if
                    end_for

                end_for
            end_if

            continue
        end_if

        # ---------------------------
        # 5. Assignment detection
        # ---------------------------
        if contains(clean, "=")

            parts = split(clean, "=")
            left = trim(parts[0])

            # Ignore control keywords
            if startswith(left, "if ")
                continue
            end_if

            if startswith(left, "else_if ")
                continue
            end_if

            if startswith(left, "function ")
                continue
            end_if

            if startswith(left, "return ")
                continue
            end_if

            name = left

            # Duplicate check
            for_each s in seen_vars
                if name == s
                    warn '[Line {line_num}] Duplicate assignment: {name}'
                end_if
            end_for

            list_add seen_vars name

            # Reserved check
            for_each r in reserved
                if name == r
                    suggestion = suggest(name)
                    warn '[Line {line_num}] Reserved assignment: {name} → try "{suggestion}"'
                end_if
            end_for

            # Risky check
            for_each x in risky
                if name == x
                    say '[INFO][Line {line_num}] Risky name: {name}'
                end_if
            end_for

        end_if

    end_for

    say ""
    say "Lint complete."

end_function

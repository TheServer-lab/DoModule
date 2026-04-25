# lint.do

function lint_reserved file_path

    local_variable = line, clean, name, left
    local_variable = reserved, risky, seen_vars
    local_variable = parts, var, line_num

    reserved = split("user_home,username,downloads,desktop,documents,appdata,temp,today,now,year,month,day,hour,minute,second,time,loop_count", ",")
    risky = split("file,path,data,input,output", ",")

    seen_vars = split("", ",")
    line_num = 0

    say ""
    say "Linting..."
    say ""

    for_each_line line in file_path

        line_num = line_num + 1
        clean = line

        # Skip comments
        if startswith(trim(clean), "#")
            continue
        end_if

        if startswith(trim(clean), "//")
            continue
        end_if

        # Remove inline comments
        if contains(clean, "#")
            clean = split(clean, "#")[0]
        end_if

        if contains(clean, "//")
            clean = split(clean, "//")[0]
        end_if

        # Remove simple strings
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

        # --- global_variable detection ---
        if startswith(clean, "global_variable")

            parts = split(clean, "=")

            if length(parts) > 1
                parts = split(parts[1], ",")

                for_each var in parts
                    name = trim(var)

                    # duplicate check
                    for_each s in seen_vars
                        if name == s
                            warn '[Line {line_num}] Duplicate variable: {name}'
                        end_if
                    end_for

                    list_add seen_vars name

                    # reserved check
                    for_each r in reserved
                        if name == r
                            warn '[Line {line_num}] Reserved variable: {name}'
                        end_if
                    end_for

                    # risky check
                    for_each x in risky
                        if name == x
                            say '[INFO][Line {line_num}] Risky name: {name}'
                        end_if
                    end_for

                end_for
            end_if

            continue
        end_if

        # --- assignment detection ---
        if contains(clean, "=")

            parts = split(clean, "=")
            left = trim(parts[0])

            # ignore control lines
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

            # duplicate check
            for_each s in seen_vars
                if name == s
                    warn '[Line {line_num}] Duplicate assignment: {name}'
                end_if
            end_for

            list_add seen_vars name

            # reserved check
            for_each r in reserved
                if name == r
                    warn '[Line {line_num}] Reserved assignment: {name}'
                end_if
            end_for

            # risky check
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

export lint_reserved

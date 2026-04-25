function lint_reserved file_path

    local_variable = line, clean, name, left
    local_variable = reserved, risky, seen_vars
    local_variable = parts, var, line_num
    local_variable = errors, warnings, infos
    local_variable = parts_len, trimmed, right

    reserved = split("user_home,username,downloads,desktop,documents,appdata,temp,today,now,year,month,day,hour,minute,second,time,loop_count", ",")
    risky = split("file,path,data,input,output", ",")

    seen_vars = split("", ",")
    line_num = 0

    errors = 0
    warnings = 0
    infos = 0

    say ""
    say "Linting..."
    say ""

    for_each_line line in file_path

        line_num = line_num + 1
        clean = line

        trimmed = trim(clean)

        # --- Skip full-line comments ---
        if startswith(trimmed, "#")
            continue
        end_if

        if startswith(trimmed, "//")
            continue
        end_if

        # --- Remove inline comments ---
        if contains(clean, "#")
            parts = split(clean, "#")
            clean = parts[0]
        end_if

        if contains(clean, "//")
            parts = split(clean, "//")
            clean = parts[0]
        end_if

        clean = trim(clean)

        if clean == ""
            continue
        end_if

        # --- Skip lines with strings (safe for 0.6.15) ---
        if contains(clean, "\"")
            continue
        end_if

        if contains(clean, "'")
            continue
        end_if

        # --- BASIC UNKNOWN COMMAND CHECK ---
        if startswith(clean, "rn ")
            warn "[Line {line_num}] Unknown command 'rn' (did you mean 'run'?)"
            warnings = warnings + 1
        end_if

        # --- GLOBAL VARIABLE DETECTION ---
        if startswith(clean, "global_variable")

            parts = split(clean, "=")
            parts_len = length(parts)

            if parts_len > 1
                parts = split(parts[1], ",")

                for_each var in parts
                    name = trim(var)

                    if name == ""
                        warn "[Line {line_num}] Empty variable name"
                        errors = errors + 1
                        continue
                    end_if

                    # invalid name
                    if contains(name, " ")
                        warn "[Line {line_num}] Invalid variable name: {name}"
                        errors = errors + 1
                    end_if

                    # duplicate check
                    for_each s in seen_vars
                        if name == s
                            warn "[Line {line_num}] Duplicate variable: {name}"
                            warnings = warnings + 1
                        end_if
                    end_for

                    list_add seen_vars name

                    # reserved check
                    for_each r in reserved
                        if name == r
                            warn "[Line {line_num}] Reserved variable: {name}"
                            warnings = warnings + 1
                        end_if
                    end_for

                    # risky check
                    for_each x in risky
                        if name == x
                            say "[INFO] Line {line_num}: Risky name → {name}"
                            infos = infos + 1
                        end_if
                    end_for

                end_for
            end_if

            continue
        end_if

        # --- ASSIGNMENT DETECTION ---
        if contains(clean, "=")

            parts = split(clean, "=")
            parts_len = length(parts)

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

            if name == ""
                warn "[Line {line_num}] Invalid assignment (missing variable name)"
                errors = errors + 1
                continue
            end_if

            # invalid name
            if contains(name, " ")
                warn "[Line {line_num}] Invalid variable name: {name}"
                errors = errors + 1
            end_if

            # empty assignment
            if parts_len > 1
                right = trim(parts[1])

                if right == ""
                    warn "[Line {line_num}] Empty assignment: {name}"
                    errors = errors + 1
                end_if
            end_if

            # duplicate check
            for_each s in seen_vars
                if name == s
                    warn "[Line {line_num}] Duplicate assignment: {name}"
                    warnings = warnings + 1
                end_if
            end_for

            list_add seen_vars name

            # reserved check
            for_each r in reserved
                if name == r
                    warn "[Line {line_num}] Reserved assignment: {name}"
                    warnings = warnings + 1
                end_if
            end_for

            # risky check
            for_each x in risky
                if name == x
                    say "[INFO] Line {line_num}: Risky name → {name}"
                    infos = infos + 1
                end_if
            end_for

        end_if

    end_for

    say ""
    say "========================================="
    say "Lint complete."
    say 'Errors: {errors}'
    say 'Warnings: {warnings}'
    say 'Info: {infos}'
    say "========================================="

end_function

# DoScript Lint Module (`lint`)

A lightweight linter for DoScript that helps you catch **reserved variable conflicts**, **duplicate declarations**, and **risky naming patterns** before they turn into runtime errors.

---

## ✨ Features

* 🔍 Detects use of **reserved (read-only) variables**
* ⚠️ Warns about **duplicate variable declarations/assignments**
* 💡 Suggests **better variable names**
* 🧠 Flags **risky naming patterns** (`file`, `data`, etc.)
* 📍 Includes **line numbers** for easy debugging
* 🧹 Ignores:

  * Comments (`#`, `//`)
  * Strings (`"..."`, `'...'`)

---

## 📦 Installation

```bash
python doscript.py install_module lint
```

---

## 🚀 Usage

```doscript
use_module "lint"

lint_reserved "your_script.do"
```

---

## 🧾 Example Output

```text
Linting (v3)...

[Line 12] Reserved variable: documents → try "doc_exts"
[Line 18] Duplicate variable: name
[INFO][Line 25] Risky name: file

Lint complete.
```

---

## 🚫 Reserved Variables Checked

The linter detects usage of DoScript built-ins such as:

```
user_home, username, downloads, desktop, documents,
appdata, temp, today, now, year, month, day,
hour, minute, second, time, loop_count
```

These variables are **read-only** and should not be reassigned.

---

## ⚠️ Risky Variable Names

The linter will warn (but not error) on names like:

```
file, path, data, input, output
```

These are allowed but discouraged due to ambiguity.

---

## 💡 Suggestions

When a reserved name is used, the linter suggests alternatives:

| Reserved  | Suggested |
| --------- | --------- |
| documents | doc_exts  |
| downloads | dl_dir    |
| time      | cur_time  |
| file      | file_item |
| data      | data_val  |

---

## 🧠 What It Detects

### 1. Reserved Variable Usage

```doscript
documents = "test"   # ❌ error
```

### 2. Duplicate Variables

```doscript
global_variable = name
global_variable = name   # ⚠️ duplicate
```

### 3. Risky Naming

```doscript
file = "example"   # ⚠️ warning
```

---

## ⚙️ Limitations

* Not a full parser (no AST)
* May not detect complex edge cases
* Suggestions are rule-based, not context-aware

---

## 🛠️ Best Practices

* Use descriptive names like:

  * `doc_exts`, `img_list`, `user_input`
* Avoid built-in variable names entirely
* Run lint before:

  * sharing scripts
  * building `.exe` installers

---

## 🔮 Future Plans

* Auto-fix mode (`lint_reserved "script.do" fix`)
* Unused variable detection
* Integration with `doscript.py --lint`
* Style enforcement rules

---

## 🤝 Contributing

Ideas, improvements, and bug reports are welcome.
This module is designed to grow with the DoScript ecosystem.

---

## 📜 License

Follow the DoScript module licensing guidelines (SOCL or project-specific license).

---

## 👋 Final Note

`lint` is one of the first tools aimed at improving **code quality** in DoScript.
Use it early, use it often 👍

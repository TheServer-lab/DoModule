# math.do — DoScript Math & Numbers Module
# Usage: use_module "math"
# Provides: abs_val, clamp, lerp, round_to, sign, is_even, is_odd,
#           factorial, fibonacci, gcd, lcm, power, safe_divide

# ── abs_val(n) ────────────────────────────────────────────────────────────────
# Returns the absolute value of n.
# Example: abs_val(-5) -> 5
function abs_val(n)
    if n < 0
        return n * -1
    end_if
    return n
end_function

# ── clamp(value, min_val, max_val) ───────────────────────────────────────────
# Clamps value between min_val and max_val (inclusive).
# Example: clamp(150, 0, 100) -> 100
function clamp(value, min_val, max_val)
    if value < min_val
        return min_val
    end_if
    if value > max_val
        return max_val
    end_if
    return value
end_function

# ── lerp(a, b, t) ────────────────────────────────────────────────────────────
# Linear interpolation between a and b by factor t (0.0 to 1.0).
# Example: lerp(0, 100, 0.25) -> 25.0
function lerp(a, b, t)
    return a + (b - a) * t
end_function

# ── round_to(value, places) ──────────────────────────────────────────────────
# Rounds value to a given number of decimal places.
# Example: round_to(3.14159, 2) -> 3.14
function round_to(value, places)
    global_variable = _rt_factor
    _rt_factor = power(10, places)
    return (value * _rt_factor + 0.5) / _rt_factor
end_function

# ── sign(n) ───────────────────────────────────────────────────────────────────
# Returns 1 if n > 0, -1 if n < 0, 0 if n == 0.
function sign(n)
    if n > 0
        return 1
    end_if
    if n < 0
        return -1
    end_if
    return 0
end_function

# ── is_even(n) ────────────────────────────────────────────────────────────────
# Returns true if n is even.
function is_even(n)
    return n % 2 == 0
end_function

# ── is_odd(n) ─────────────────────────────────────────────────────────────────
# Returns true if n is odd.
function is_odd(n)
    return n % 2 != 0
end_function

# ── factorial(n) ──────────────────────────────────────────────────────────────
# Returns n! (factorial). n must be >= 0.
# Example: factorial(5) -> 120
function factorial(n)
    global_variable = _fact_result, _fact_i
    _fact_result = 1
    _fact_i = 2
    loop n as _fi
        if _fact_i <= n
            _fact_result = _fact_result * _fact_i
            _fact_i = _fact_i + 1
        end_if
    end_loop
    return _fact_result
end_function

# ── fibonacci(n) ──────────────────────────────────────────────────────────────
# Returns the nth Fibonacci number (0-indexed).
# Example: fibonacci(7) -> 13
function fibonacci(n)
    global_variable = _fa, _fb, _fc, _fi
    if n == 0
        return 0
    end_if
    if n == 1
        return 1
    end_if
    _fa = 0
    _fb = 1
    _fi = 2
    loop n as _fbi
        if _fi <= n
            _fc = _fa + _fb
            _fa = _fb
            _fb = _fc
            _fi = _fi + 1
        end_if
    end_loop
    return _fb
end_function

# ── gcd(a, b) ─────────────────────────────────────────────────────────────────
# Greatest common divisor of a and b (Euclidean algorithm).
# Example: gcd(48, 18) -> 6
function gcd(a, b)
    global_variable = _ga, _gb, _gt
    _ga = a
    _gb = b
    loop 1000 as _gi
        if _gb != 0
            _gt = _gb
            _gb = _ga % _gb
            _ga = _gt
        end_if
    end_loop
    return _ga
end_function

# ── lcm(a, b) ─────────────────────────────────────────────────────────────────
# Least common multiple of a and b.
# Example: lcm(4, 6) -> 12
function lcm(a, b)
    global_variable = _lg
    _lg = gcd(a, b)
    return (a * b) / _lg
end_function

# ── power(base, exp) ──────────────────────────────────────────────────────────
# Returns base raised to the power of exp (integer exponent >= 0).
# Example: power(2, 10) -> 1024
function power(base, exp)
    global_variable = _pr, _pi
    _pr = 1
    _pi = 0
    loop exp as _pli
        if _pi < exp
            _pr = _pr * base
            _pi = _pi + 1
        end_if
    end_loop
    return _pr
end_function

# ── safe_divide(a, b) ─────────────────────────────────────────────────────────
# Divides a by b. Returns 0 if b is 0 (no crash).
# Example: safe_divide(10, 0) -> 0
function safe_divide(a, b)
    if b == 0
        return 0
    end_if
    return a / b
end_function

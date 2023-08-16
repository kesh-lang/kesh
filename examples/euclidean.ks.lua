[abs]: import Math

gcd: (a, b) ->
    a: abs(a)
    b: abs(b)
    a if b = 0 else gcd(b, a rem b)

[gcd]

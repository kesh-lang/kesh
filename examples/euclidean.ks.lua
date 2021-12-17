import [abs]: Math

euclidean: (a, b) ->
    a: abs(a)
    b: abs(b)
    a if b = 0 else euclidean(b, a mod b)

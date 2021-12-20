-- tail recursion
fib: (n) ->
    n if n < 2 else fib(n - 1) + fib(n - 2)

-- memoized
fib-memoized: (n, memo ? *[]) ->
    if memo.(n)? then memo.(n)
    else if n < 2 then n
    else set memo.(n): fib-memoized(n - 1, memo) + fib-memoized(n - 2, memo)

[fib, fib-memoized]

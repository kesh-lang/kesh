-- tail recursion
fib: (n) ->
    n if n < 2 else fib(n - 1) + fib(n - 2)

-- memoized
fib-mem: (n, memo ? *[]) ->
    memo.{n} if memo.{n}?
        else n if n < 2
        else set memo.{n}: fib-mem(n - 1, memo) + fib-mem(n - 2, memo)

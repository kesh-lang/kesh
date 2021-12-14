-- silly example to demonstrate the generator and imperative loop extensions

fizzbuzz: (n) *=>
    loop 1..n as i
        yield "FizzBuzz" if i mod 15 = 0
            else "Fizz" if i mod 3 = 0
            else "Buzz" if i mod 5 = 0
            else i

loop fizzbuzz 100 as result
    print result

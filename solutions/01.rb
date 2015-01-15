def fibonacci(n)
 return n if n == 1
 return 1 if n == 2
 fibonacci( n - 1 ) + fibonacci( n - 2 )
end

def lucas(n)
  return 2 if n == 1
  return 1 if n == 2
  lucas( n - 1 ) + lucas( n - 2 )
end

def summed(n)
    fibonacci(n) + lucas(n)
end

def series(sequence,n)
  return fibonacci(n) if sequence == 'fibonacci'
  return lucas(n)     if sequence == 'lucas'
  return summed(n)    if sequence == 'summed'
end
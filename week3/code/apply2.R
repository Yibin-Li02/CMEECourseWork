#__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
#__version__ = '0.0.1'

SomeOperation <- function(v) {
  if (sum(v) > 0) { #note that sum(v) is a single (scalar) value
    return (v * 100)
  } else { 
  return (v)
    }
}

M <- matrix(rnorm(100), 10, 10)
print (apply(M, 1, SomeOperation))


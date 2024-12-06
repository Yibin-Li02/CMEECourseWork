#__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
#__version__ = '0.0.1'


for (i in 1:10) {  # Loop over numbers from 1 to 10
  if ((i %% 2) == 0)  # Check if 'i' is even (remainder of division by 2 is 0)
    next  # Skip this iteration if 'i' is even and move to the next iteration
  print(i)  # Print 'i' if it's odd
}
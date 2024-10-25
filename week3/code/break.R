#__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
#__version__ = '0.0.1'

i <- 0  # Initialize i to 0
while (i < Inf) {  # Loop infinitely until a break condition is met
    if (i == 10) {  # Check if i equals 10
        break  # Exit the loop if i is 10
    } else {  # Otherwise, continue in the loop
        cat("i equals", i, "\n")  # Print the current value of i with formatting
        i <- i + 1  # Increment i by 1
    }
}

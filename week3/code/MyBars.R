#__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
#__version__ = '0.0.1'


# Load the ggplot2 package for plotting
require(ggplot2)

# read data
a <- read.table("../data/Results.txt", header = TRUE)

# view data
head(a)

# append a column of zeros
a$ymin <- rep(0, dim(a)[1]) 

# Print the first linerange
p <- ggplot(a)
p <- p + geom_linerange(data = a, aes(
  x = x,
  ymin = ymin,
  ymax = y1,
  size = (0.5)
),
colour = "#E69F00",
alpha = 1/2, show.legend = FALSE)

# Print the second linerange
p <- p + geom_linerange(data = a, aes(
  x = x,
  ymin = ymin,
  ymax = y2,
  size = (0.5)
),
colour = "#56B4E9",
alpha = 1/2, show.legend = FALSE)

# Print the third linerange:
p <- p + geom_linerange(data = a, aes(
  x = x,
  ymin = ymin,
  ymax = y3,
  size = (0.5)
),
colour = "#D55E00",
alpha = 1/2, show.legend = FALSE)

# Annotate the plot with labels:
p <- p + geom_text(data = a, aes(x = x, y = -500, label = Label))

# now set the axis labels, remove the legend, and prepare for bw printing
p <- p + scale_x_continuous("My x axis",
                            breaks = seq(3, 5, by = 0.05)) +
  scale_y_continuous("My y axis") +
  theme_bw() +
  heme(legend.position = "none")

p
print(p)
ggsave("../results/MyBars.pdf", plot = p)
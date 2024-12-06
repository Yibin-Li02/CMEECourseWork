#__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
#__version__ = '0.0.1'


################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

############# Load the dataset ###############
# Load the raw dataset as a matrix.
MyData <- as.matrix(read.csv("../data/PoundHillData.csv",header = F))

# Metadata contains descriptive information about the dataset.
MyMetaData <- read.csv("../data/PoundHillMetaData.csv",
                       header = T,
                       sep=";",
                       stringsAsFactors = F)

############# Inspect the dataset ###############
# View the first few rows of the raw dataset to get an initial understanding of the data structure.
head(MyData)

# Get the dimensions of the dataset (rows and columns).
dim(MyData)

# Get the structure of the dataset, including data types of each element.
str(MyData)

############# Transpose ###############
# Transpose the dataset to convert species into columns and treatments into rows.
MyData <- t(MyData)

############# Replace species absences with zeros ###############
# Replace all empty values (indicating species absence) with zeros.
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############
TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F)
colnames(TempData) <- MyData[1,] # assign column names from original data

############# Convert from wide to long format  ###############
# Load the reshape2 package for data transformation.
require(reshape2) # load the reshape2 package

# Use the melt function to convert the data frame from wide format to long format.
# In the long format, each row represents a single observation.
MyWrangledData <- melt(TempData,
                       id=c("Cultivation", "Block", "Plot", "Quadrat"),
                       variable.name = "Species",
                       value.name = "Count")

# Convert relevant columns to factors for easier analysis.
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])

# Convert the "Count" column to integer type, as it represents numerical values.
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

# Inspect the structure of the wrangled dataset to verify the changes.
str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

############# Exploring the data (extend the script below)  ###############
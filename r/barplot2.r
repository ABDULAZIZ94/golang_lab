# Install the necessary packages if you haven't already
# install.packages("RPostgres")
# install.packages("ggplot2")

# Load the libraries
library(DBI)
library(RPostgres)
library(ggplot2)

# Create a connection to the PostgreSQL database
con <- dbConnect(
  RPostgres::Postgres(),
  dbname = "smarttoilet-staging",
  host = "alpha.vectolabs.com",
  port = 9998,          # Custom port for PostgreSQL
  user = "postgres",
  password = "VectoLabs)1"
)

# Check if the connection is successful
if (dbIsValid(con)) {
  print("Connection successful!")
} else {
  print("Connection failed.")
}

# Execute a SELECT query
query <- "SELECT * FROM enviroment_data LIMIT 100;"
result <- dbGetQuery(con, query)

# Print the result
# print(result)

# Close the connection when you're done
dbDisconnect(con)

# Create a scatter plot (bar plot)
# ggplot(result, aes(x = timestamp, y = lux)) +
#   geom_bar(stat = "identity") +
#   labs(title = "Bar Plot of lux vs timestamp",
#        x = "Timestamp",
#        y = "Lux")

# If you want to use base R's barplot function:
barplot(height = result$lux, names.arg = result$timestamp,
        main = "Bar Plot of lux vs timestamp",
        xlab = "Timestamp",
        ylab = "Lux",
        las = 2,            # Makes the labels perpendicular to the axis
        col = "skyblue")

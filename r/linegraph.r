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

# Execute a SELECT query with a timestamp range
query <- "SELECT * FROM enviroment_data 
          WHERE timestamp BETWEEN to_timestamp('2024-08-01 00:00:00','YYYY-MM-DD HH24:MI:SS') 
          AND to_timestamp('2024-08-10 00:00:00','YYYY-MM-DD HH24:MI:SS');"
result <- dbGetQuery(con, query)

# Close the connection when you're done
dbDisconnect(con)

# Convert timestamp to POSIXct for proper plotting
result$timestamp <- as.POSIXct(result$timestamp)

# Give the chart file a name
png(file = "linechart.jpg")

# Plot the line chart
plot(result$timestamp, result$lux, type = "l", col = "black", 
     xlab = "Timestamp", ylab = "Values", main = "Environmental Data Over Time")

# Add additional lines to the plot
lines(result$timestamp, result$temperature, col = "#ffff00")
lines(result$timestamp, result$humidity, col = "#d12643")
lines(result$timestamp, result$iaq, col = "blue")

# Add a legend to the plot
legend("topright", legend = c("Lux", "Temperature", "Humidity", "IAQ"),
       col = c("black", "#ffff00", "#d12643", "blue"), lty = 1)

# Save the file
dev.off()

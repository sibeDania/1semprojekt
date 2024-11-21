library(odbc)
library(DBI)

readRenviron("~/GitHub/1semprojekt/.Renviron")

con <- dbConnect(odbc(),
                 Driver = "ODBC Driver 18 for SQL Server",
                 Server = Sys.getenv("server"),
                 Database = Sys.getenv("database"),
                 Port = "1433",
                 UID = Sys.getenv("user"),
                 PWD = Sys.getenv("pwd"))


dbExecute(con, "CREATE SCHEMA dania2;")

table <- "CREATE TABLE dania2.df(
row_id VARCHAR(1000),
category VARCHAR(1000),
value VARCHAR(1000)
)"

dbExecute(con, table)

###

data <- data.frame(
  row_id = 1:20,
  category = sample(c("A", "B", "C"), 20, replace = 20),
  value = round(runif(20, min = 10, max = 100), 2)
)

### Skriv min data dataframe til en tabel

id <- DBI::Id(schema = "dania2",
              table = "df")


dbWriteTable(con, name = id, value = data, row.names = FALSE, append = TRUE)

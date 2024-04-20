clean_df <- function(data) {
  data$marriage <- NA
  data$marriage[data$burgstat_2020 < 5] <- 1
  data$marriage[data$burgstat_2020 == 5] <- 2
  return(data)
}

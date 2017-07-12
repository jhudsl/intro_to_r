bike %>% mutate(
  high = ifelse(length > 200 & is.na(high), 
                "high", high),
  high = ifelse(length > 100 & is.na(high), 
                "med", high),
  high = ifelse(length > 100 & is.na(high), 
                "low", high),
  high = length > 200,
  path = type == "SIDEPATH",
  path = ifelse(type == "SIDEPATH",
                "This_is_a_sidepath", 
                "not_one")
) 

# bike %>% mutate(
#   good_date = ifelse( site == "US",
#                     mdy(date),
#                     dmy(date)
# ) 

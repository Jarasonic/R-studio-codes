library(readxl)
library(tidyverse)

Audit_regions <- read_excel("audit_regions_states_markets_occupancy_stat (version 1).xlsx", sheet="Sheet2")



#find the number( of occupied and locked up spaces in each market, and their percentage

Audit_regions %>%
  group_by(markets) %>%
  summarise(frequency = n(),  )


Market_count <- Audit_regions %>%
  group_by(markets) %>%
  summarise(frequency= n(), totalcount = sum(count))


Occupied <- subset(Audit_regions, occupancy == "OCCUPIED") %>%
  group_by(markets) %>% 
  summarise(occupied= sum(count))


Locked_up <- subset(Audit_regions, occupancy == "LOCKED UP") %>%
  group_by(markets) %>%
  summarise(locked_up=sum(count))

Others <- subset(Audit_regions, occupancy !="LOCKED UP" & occupancy != "OCCUPIED") %>%
  group_by(markets) %>%
  summarise(others=sum(count))

table <- merge(Market_count, Occupied, by = "markets", all.x=TRUE)
table<- merge(table, Locked_up, by ="markets", all.x = TRUE)
table <- merge(table, Others, by = "markets", all.x = TRUE)

Finaltable1 <- mutate(table, percentage_occupied = occupied/totalcount * 100)
Finaltable2 <- mutate(Finaltable1, percentage_locked_up = locked_up/totalcount * 100)
Fianltable3 <- mutate(Finaltable2, percentage_other = others/totalcount *100)

write.csv(Fianltable3, "Test2.csv", row.names=FALSE)

non_merge <- anti_join(x=Market_count, y=Occupied, by = "markets")

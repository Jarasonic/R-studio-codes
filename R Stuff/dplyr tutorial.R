library(dplyr)
library(dslabs)
data(murders)
murders <- mutate(murders, population_in_millions = population / 10^6)
select(murders, state, population) |> head()
filter(murders, state == "New York")

murders <- mutate(murders, rate =  total / population * 100000, 
                  rank = rank(-rate))

my_states <- filter(murders, region %in% c("Northeast", "West") & 
                      rate < 1)

select(my_states, state, rate, rank)
select(my_states, state, rate, rank)|> mutate(murders, rate =  total / population * 100000, 
         rank = rank(-rate)) |>
  select(state, rate, rank)
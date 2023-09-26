#packages for today
#dplyr: swiss army knife for manipulating data
#tidyr: has a bit more than dplyr, can do pivot tables
#palmerpenguins: toy data set package based on penguins to play with today


install.packages("dplyr")
install.packages("tidyr")
install.packages("palmerpenguins")

library(dplyr)
library (tidyr)
library(palmerpenguins) #need to do this first

penguins_data <- penguins #assigning data to object

class(penguins_data) #identifying class of data

head(penguins_data) #shows that there are more variables
#this is important to check - what data type you have has downstream consequences

#major data types in r - integers, double - decimal points, boolean- true false
#character strings - text, categorical data - factors - stored as text

str(penguins_data) #structure function - shows variables and what type of variable they are
unique(penguins_data$species) #see all three species

#you can set the order for a factor in r
#to see if/how a factor is currently ordered

levels(penguins_data$island) #to see factors

is.ordered(penguins_data$island) #to see if it is an ordinal factor, the order means something

#If you want to just try something out, run in the console. If you want to keep for later, R script.
#This allows you to keep the R script clean

#missing data is encoded as NA in R - R will treat this data with extra care
#avoid doing -99 

#R is a vectorized programming language - sometimes you can do something to the whole vector at once

mean(penguins_data$body_mass_g)
#because there is missing data, R will say NA for response
#can override with na.rm = TRUE

mean(penguins_data$body_mass_g, na.rm = TRUE)
#ignores missing values 

years_of_sampling <- paste("Year:", penguins_data$year)
#adds the text year to each value in the year variable
#now you can't calculate mean year because it has letters

str(penguins_data) #see the data variables

island_year <- select(penguins_data, island, year)
str(island_year)
#when you want to see islands by year

#what if we want to pull data based on rows - e.g., rows from Torgersen island?

torgersen_penguins <- filter(penguins_data, island == "Torgersen")

torgersen_penguins_only_sex_and_species <- select(torgersen_penguins, sex, species)
str(torgersen_penguins_only_sex_and_species)

#Pipe = how to do this in one command rather than in sequential operations
#helps you keep a much cleaner workspace
#ctrl shift m - %>%  - take the output of this line and feed it to the next line of code

torgerson_penguins_one_chunk <- filter (penguins_data, island == "Torgersen") %>%
  select(sex, species)

#if we wanted to create a new column or change a column, the dplyr function is mutate
#what if we want to round values for bill length

torgersen_penguins <- torgersen_penguins %>% 
  mutate(rounded_bill_length = round(bill_length_mm) %>% 
  select(species, sex, rounded_bill_length)

torgersen_penguins_summary <- torgersen_penguins %>% 
  group_by(species, sex) %>% 
  summarize(mean_bill_length = mean(rounded_bill_length, na.rm = TRUE))
#means for female versus male

torgersen_penguins_summary

penguin_counts <- penguins_data %>% 
  group_by(species, sex, island) %>% 
  summarize(n

penguin_counts

penguins_wide <- penguin_counts %>% 
  pivot_wider(id_cols = c(species, sex), names_from = island, values_from = n, values_fill = 0)

penguins_wide

penguins_long_again <- penguins_wide %>% 
  pivot_longer(-c(species, sex), values_to = "count")

penguins_long_again

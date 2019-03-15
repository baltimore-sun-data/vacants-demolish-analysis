Analysis: vacant buildings to be demolished
-------------------------------------------

The Baltimore Sun obtained a list of vacant buildings to be demolished from the Baltimore City Department of Housing & Community Development. The following analysis provided the numbers in a March 15, 2019 Baltimore Sun story titled "Baltimore officials pledge to demolish 2,100 vacant houses by next summer."

Here are the key statistics reported in the story:

-   There are almost 17,000 vacant buildings in the city currently.
-   1,803 properties are scheduled for demolition by June 30, 2020.
-   Eighty percent of the properties scheudled for demolition by FY 2020 are in just 16 neighborhoods.
-   Broadway East is projected to see 271 vacants come down. Sandtown-Winchester, 199, and Harlem Park, 143.
-   Coldstream Homestead Montebello currently has 448 abandoned buildings and is projected to see 87 demolitions by next summer.
-   Broadway East currently has 1,166 vacant buildings.
-   Carrollton Ridge currently has 780 vacant buildings, and 62 properties in the neighborhood are slated for demolition.

### Load R libraries

``` r
library('tidyverse')
library('janitor')
library('RSocrata')
```

### Finding: There are almost 17,000 abandoned buildings blighting the city’s streets.

Data on Baltimore's vacant buildings is from [Open Baltimore](https://data.baltimorecity.gov/Housing-Development/Vacant-Buildings/qqcv-ihn5/). The file, which was last updated Feb. 15, 2019 was downloaded directly via the `RSocrata` package and saved as a .csv file in the `input/` folder.

``` r
# vacants <- read.socrata('https://data.baltimorecity.gov/Housing-Development/Vacant-Buildings/qqcv-ihn5/') %>% 
#   clean_names() %>%
#   filter(buildingaddress != "0" & buildingaddress != "0  " & buildingaddress != "")

# write_csv(vacants, 'input/vacants.csv') # this version was last updated Feb. 15, 2019

vacants <- read_csv('input/vacants.csv') %>% mutate(neighborhood = toupper(neighborhood))

print(paste("There are currently", 
            length(unique(vacants$buildingaddress)), 
            "vacant buildings according to Open Baltimore as of Feb. 14, 2019."))
```

    ## [1] "There are currently 16724 vacant buildings according to Open Baltimore as of Feb. 14, 2019."

### Finding: 1803 properties are scheduled for demolition by June 30, 2020.

Data on vacant buildings scheduled for demolition is from a file provided by the Baltimore City Department of Housing & Community Development. The raw file was pre-processed prior to analysis. See `01_processing.md` for more details.

Here we'll read in the data and filter out buildings slated for FY 2021 (e.g., June 30, 2021) demolition.

``` r
demolish <- read_csv('output/demolish_list_clean.csv')
```

    ## Parsed with column specification:
    ## cols(
    ##   address = col_character(),
    ##   status = col_character(),
    ##   neighborhood = col_character(),
    ##   projected_release_to_contractor = col_character(),
    ##   long = col_double(),
    ##   lat = col_double(),
    ##   group_address = col_character(),
    ##   property_count_in_range = col_double()
    ## )

``` r
print(paste(demolish %>% filter(status != 'FY21' | is.na(status)) %>% summarise(n = n()),
            "properties are scheduled for demolition by June 30, 2020."))
```

    ## [1] "1806 properties are scheduled for demolition by June 30, 2020."

### Finding: Eighty percent of the properties scheudled for demolition by FY 2020 are in just 16 neighborhoods.

Summarize the `demolish` dataframe by neighborhood and calculate the cumulative sum of vacants and percentage.

``` r
properties.by.neighborhood <- 
  demolish %>% 
  filter(status != 'FY21') %>% 
  group_by(neighborhood) %>% 
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  mutate(cumulative = cumsum(n),
         cumulative_perc = cumulative/sum(n) * 100,
         rank = row_number())

number_to_rank <- 16

print(paste(round(properties.by.neighborhood[properties.by.neighborhood$rank == number_to_rank, ]$cumulative_perc),
      "percent of the vacant buildings scheduled for demolition by FY 2020 are in",
      number_to_rank, "neighborhoods."))
```

    ## [1] "80 percent of the vacant buildings scheduled for demolition by FY 2020 are in 16 neighborhoods."

### Finding: Broadway East is projected to see 271 vacants come down. Sandtown-Winchester, 199, and Harlem Park, 143.

Use the summarized `properties.by.neighborhood` dataframe to get these statistics.

``` r
neighborhood.1 = 'BROADWAY EAST'
neighborhood.2 = 'SANDTOWN-WINCHESTER'
neighborhood.3 = 'HARLEM PARK'

print(paste(neighborhood.1,
            "is projected to see",
            properties.by.neighborhood[properties.by.neighborhood$neighborhood == neighborhood.1, ]$n,
            "come down.",
            neighborhood.2,
            properties.by.neighborhood[properties.by.neighborhood$neighborhood == neighborhood.2, ]$n,
            "and",
            neighborhood.3,
            properties.by.neighborhood[properties.by.neighborhood$neighborhood == neighborhood.3, ]$n))
```

    ## [1] "BROADWAY EAST is projected to see 271 come down. SANDTOWN-WINCHESTER 199 and HARLEM PARK 143"

### Finding: Coldstream Homestead Montebello currently has 448 abandoned buildings and is projected to see 87 demolitions by next summer.

Use the `vacants` and the summarized `properties.by.neighborhood` dataframes to get these statistics.

``` r
vacants.by.neighborhood <- vacants %>% 
  group_by(neighborhood) %>% summarise(n = n())

print(paste("COLDSTREAM HOMESTEAD MONTEBELLO currently has", 
            vacants.by.neighborhood[grepl("COLDSTREAM", vacants.by.neighborhood$neighborhood), ]$n,
            "abandoned buildings and is projected to see",
            properties.by.neighborhood[grepl("COLDSTREAM", properties.by.neighborhood$neighborhood), ]$n,
            "demolitions by next summer."))
```

    ## [1] "COLDSTREAM HOMESTEAD MONTEBELLO currently has 448 abandoned buildings and is projected to see 87 demolitions by next summer."

### Finding: Broadway East currently has 1,166 vacant buildings.

Use the summarized `vacants.by.neighborhood` dataframes to get this statistic.

``` r
print(paste(neighborhood.1, "currently has", 
            vacants.by.neighborhood[vacants.by.neighborhood$neighborhood == neighborhood.1, ]$n,
            "vacant buildings."))
```

    ## [1] "BROADWAY EAST currently has 1166 vacant buildings."

### Finding: Carrollton Ridge currently has 780 vacant buildings, and 62 properties in the neighborhood are slated for demolition.

Use the `vacants.by.neighborhood` and the summarized `properties.by.neighborhood` dataframes to get these statistics.

``` r
print(paste("CARROLLTON RIDGE currently has", 
            vacants.by.neighborhood[grepl("CARROLLTON", vacants.by.neighborhood$neighborhood), ]$n,
            "abandoned buildings and is projected to see",
            properties.by.neighborhood[grepl("CARROLLTON", properties.by.neighborhood$neighborhood), ]$n,
            "demolitions by next summer."))
```

    ## [1] "CARROLLTON RIDGE currently has 780 abandoned buildings and is projected to see 62 demolitions by next summer."
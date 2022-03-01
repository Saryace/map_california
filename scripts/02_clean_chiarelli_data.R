
# Load california shapes for selecting data -------------------------------

states <- map_data("state")

california_df <- subset(states, region == "california") 

california_sf <- st_as_sf(california_df, coords = c("long", "lat"),
                          crs = 4326) %>%
  mutate(lat = sf::st_coordinates(.)[,1],
         lon = sf::st_coordinates(.)[,2])

mapview(california_sf) # check if california coordenates are ok

# Label data according to state -------------------------------------------

data_world_irrigated$states <- map.where(database = "state",
                                         data_world_irrigated$lon,
                                         data_world_irrigated$lat)

# Select california data --------------------------------------------------

data_world_irrigated_ca <-
  data_world_irrigated %>%
  filter(states == "california") %>%
  mutate(
    Rate_GWBW_irr_discrete = case_when(
      Rate_GWBW_irr < 0.05 ~ "0 - 5%",
      Rate_GWBW_irr >= 0.05 &
        Rate_GWBW_irr < 0.1  ~ "5 - 10%",
      Rate_GWBW_irr >= 0.1 &
        Rate_GWBW_irr < 0.2  ~ "10 - 20%",
      Rate_GWBW_irr >= 0.2 &
        Rate_GWBW_irr < 0.3  ~ "20 - 30%",
      Rate_GWBW_irr >= 0.3 &
        Rate_GWBW_irr < 0.4  ~ "30 - 40%",
      TRUE ~ "More than 40%"
    )
  ) 

data_world_irrigated_ca_sf <- st_as_sf(data_world_irrigated_ca,
                                       coords = c("lon", "lat"),
                                       crs = 4326) 


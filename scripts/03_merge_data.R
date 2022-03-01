# Matching data from paper with FMMP --------------------------------------

sf::sf_use_s2(FALSE) # making planar, see https://r-spatial.github.io/sf/articles/sf7.html

data_irrigation_ca <- st_intersection(data_world_irrigated_ca_sf,
                                      statewide_shape) 

data_irrigation_ca <-data_irrigation_ca %>% 
  dplyr::mutate(lat = sf::st_coordinates(.)[,1],
                lon = sf::st_coordinates(.)[,2])



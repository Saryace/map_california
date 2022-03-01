
# Library -----------------------------------------------------------------

library(tidyverse)

# Run scripts -------------------------------------------------------------

# List files and source each
list.files("scripts", pattern="\\.R$", full.names = T) %>% 
  purrr::map(source) 

# check data using mapview ------------------------------------------------

mapview(data_world_irrigated_ca_sf)  # data from Chiarelli's paper

mapview(data_irrigation_ca) # data crossed with FMMP shapes

# Plotting ----------------------------------------------------------------

plot_irrigation

plot_rain

figure_1

# Saving figure in tiff ---------------------------------------------------

#change res = 600 for publication quality
tiff("figures/figure_1.tiff", units="in", width=15, height=9, res= 100)

figure_1

dev.off()




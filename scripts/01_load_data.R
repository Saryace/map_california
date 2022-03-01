
# Load data ---------------------------------------------------------------
# Data from .NC files (see paper metadata)
# https://www.nature.com/articles/s41597-020-00612-0
# each .NC file is 1 - 2 GB so I summarized them to .csv

data_world_irrigated <- read.csv(unz("data/data_world_irrigated.zip", 
                                     "data_world_irrigated.csv"), header = TRUE,
                        sep = ",") 

# Load shapes FMMP for irrigated areas ------------------------------------

# Data from:
# https://gis.conservation.ca.gov/portal/home/item.html?id=16689151f4d240d2a16232ea650a6c62
# Statewide data is 250Mb size, this part can be run if you download the shapes

#statewide_shape <- st_read("data/statewide2016.shp")

# subsetting P = Prime Farmland (P). see metadata from https://gis.conservation.ca.gov/
# "S" = Farmland of Statewide Importance (S)
#statewide_shape_subset <- subset(statewide_shape, polygon_ty == "P" | polygon_ty == "S")

# making sure CRS to 4326 
# NAD83 (EPSG:4269 or 4267) Most commonly used by U.S. federal agencies.

#statewide_shape <- st_transform(statewide_shape_subset, 4326) 


# Load shape already subsetted --------------------------------------------



statewide_shape <- st_read("data/statewide_shape.shp")


                   


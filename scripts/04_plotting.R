# Plotting style ----------------------------------------------------------

plain_style <- theme(
  axis.text = element_blank(),
  axis.line = element_blank(),
  axis.ticks = element_blank(),
  panel.border = element_blank(),
  panel.grid = element_blank(),
  axis.title = element_blank(),
  plot.background = element_rect(fill = "transparent", color = NA),
  panel.background = element_rect(fill = "transparent"),
  plot.title = element_text(hjust = 0, size =15),
  legend.position = "bottom") +
  theme(legend.text=element_text(size=12),
        legend.title=element_text(size=12)) 


# Plotting irrigated points -----------------------------------------------

us_geo <- tigris::states(class = "sf", cb = TRUE) %>%
  filter(NAME == "California")

plot_irrigation <- us_geo %>% 
  ggplot() +
  geom_sf(color = "grey40", fill="grey80") +
  geom_sf(
    data = data_irrigation_ca,
    size = 1,
    inherit.aes = FALSE,
    mapping = aes(
      x = lon,
      y = lat,
      color = fct_reorder(Rate_GWBW_irr_discrete, Rate_GWBW_irr)
    )
  ) +
  coord_sf(
    default_crs = sf::st_crs(4326),
    xlim = c(-124,-114),
    ylim = c(32, 42)
  ) +
  scale_color_viridis_d(direction = -1) +
  guides(color = guide_legend(override.aes = list(size = 5))) +
  labs(color = "Annual fraction\nof greenwater in\nirrigated systems (%)") +
  plain_style +
  ggtitle('B') +
  labs(x="",y="") +
  ggspatial::annotation_scale(
    location = "tr",
    bar_cols = c("grey60", "white")
  ) +
  ggspatial::annotation_north_arrow(
    location = "tr", which_north = "true",
    pad_x = unit(0.4, "in"), pad_y = unit(0.4, "in"),
    style = ggspatial::north_arrow_nautical(
      fill = c("grey40", "white"),
      line_col = "grey20"
    )
  )


# Plotting precipitation --------------------------------------------------
# Tutorial: https://bookdown.org/huckley/microclimate_users_guide/gridmet.html

rain <- getGridMET(aoi_get(state = "CA"), 
                   param = "prcp",
                   startDate = "2016-01-01",
                   endDate = "2016-12-31")

rains <- stack(rain)

totalrain <- calc(rains, sum) # annual

totalrain <- as.data.frame(totalrain, xy=TRUE) %>% drop_na()

totalrain$states <- map.where(database = "state", totalrain$x, totalrain$y)

totalrain$layer<- totalrain$layer / 10 


map_totalrain <- totalrain %>% filter(states == "california") 


map_totalrain <- st_as_sf(map_totalrain, coords = c("x", "y"), crs = 4326) 

plot_rain <- us_geo %>% 
  ggplot() +
  geom_sf() +  
  geom_sf(data=map_totalrain, aes(color=layer), size = 1) +
  coord_sf(
    default_crs = sf::st_crs(4326),
    xlim = c(-124,-114),
    ylim = c(32, 42)
  ) +
  scale_color_viridis_c(
    na.value = "grey60",
    limits = c(0, 350),
    direction = -1) +
  labs(color = "Annual\nprecipitation\n(cm)") +
  theme(legend.text=element_text(size=12, angle=45)) +
  ggtitle('A') +
  plain_style +
  labs(x="",y="") +
  ggspatial::annotation_scale(
    location = "tr",
    bar_cols = c("grey60", "white")
  ) +
  ggspatial::annotation_north_arrow(
    location = "tr", which_north = "true",
    pad_x = unit(0.4, "in"), pad_y = unit(0.4, "in"),
    style = ggspatial::north_arrow_nautical(
      fill = c("grey40", "white"),
      line_col = "grey20"
    )
  )


# Combine both plots ------------------------------------------------------

figure_1 <- plot_rain + plot_irrigation + plot_annotation(
  title = 'California, 2016',
  theme = theme(plot.title = element_text(size = 22)),
  caption = 'Sources: Chiarelli et al., 2020\ngridMET (2021)\nFarmland Mapping and Monitoring Program (2021)'
) &
  theme_minimal()  + 
  theme(
    legend.justification = "bottom",
    text = element_text(colour = "grey40", size = 18),
    panel.border = element_rect(colour = "grey40", fill=NA, size=2)
  )


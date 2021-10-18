


plotPopulation <- function(plot_table){
  plot <- ggplot(plot_table) +
    geom_point(mapping = aes(x=year, y=points, color = dem_comp)) +
    scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
    theme(axis.text.x = element_text(face="bold", color="#993333", 
                                     size=10, angle=90),
          axis.text.y = element_text(face="bold", color="#993333", 
                                     size=10, angle=0))
  return(plot)
}


plotNat_Mort <- function(plot_table){
  plot <- ggplot(plot_table) +
    geom_point(mapping = aes(x=year, y=points, color = dem_comp)) +
    #scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
    theme(axis.text.x = element_text(face="bold", color="#993333", 
                                     size=10, angle=90),
          axis.text.y = element_text(face="bold", color="#993333", 
                                     size=10, angle=0))
  return(plot)
}

plotGDPCostaRica <- function(plot_table){
  plot <-  ggplot(plot_table, aes(x = year, y = gdp))+
    geom_line(color = "#00AFBB", size = 2) + 
    scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6))
  return(plot)
}

plotGDPWord <- function(plot_table){
  
  g1 <- subset(plot_table, country_name == "Costa Rica")
  
  gg_point = ggplot(plot_table) +
    scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
    geom_point_interactive(aes(x = country_name, y = gdp2019,
                               tooltip = country_name_gdp, data_id = gdp2019)) +
    theme(axis.title.x=element_blank(),
          axis.text.x=element_blank(),
          axis.ticks.x=element_blank())
  return(gg_point)
}





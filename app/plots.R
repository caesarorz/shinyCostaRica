


plotPopulation <- function(plot_table){
  print(plot_table)
  plot <- ggplot(plot_table) +
    geom_point(mapping = aes(x=year, y=points, color = dem_comp)) +
    scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
    theme(axis.text.x = element_text(face="bold", color="#993333", 
                                     size=10, angle=90),
          axis.text.y = element_text(face="bold", color="#993333", 
                                     size=10, angle=0))
  return(plot)
}
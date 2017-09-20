#Grouped bar graph for continous data
#Emily Mills 9/20/17.
#This script creates a simple grouped bar graph, visualizing percent overlap of different change detection methods
#with different reference datasets

#set working directory to project directory/folder where data resides
setwd("X:/GIS/CBP_Change_Detection/Scripts/CompGraphs_GFC_ImpGain")

#load ggplot2 graphing package
library(ggplot2)

#read in data and print to make sure it looks right
ovlp<- read.csv("Ovlp.csv", header = TRUE)
print(ovlp)

#format the graph

ggplot(data= ovlp, aes(x= Grp1, y = Pct_Ovlp, group=Grp2)) + #aes set x and y variables, and grouping variable that will appear in legend
  geom_bar(position= "dodge", color= "black", stat="identity", aes(fill = Grp2), width = .7)+ #add bars- color=outline color, fill= by grouping variable, width=bar width
  labs(x= "Reference data set", y = "Percent overlap with reference")+ #add custom label text for each axis
  theme_classic()+ #choose a graph theme
  theme(axis.title = element_text(face = "bold", color = "black", size = 28), #format text of axis titles
        axis.text.x = element_text(color= "black", size = 22, margin = margin(b=20)), #format text of axis labels. margin controls spacing from axis
        axis.text.y = element_text(color="black", size = 22, margin= margin(l=10)), #format text of axis labels. margin controls spacing from axis
        legend.text = element_text(size = 20), #format legend text
        legend.title = element_text(face = "bold", size = 26), #format legend title
        legend.key.size = unit(2, 'lines'))+ #format line spacing in legend
  scale_fill_manual(name="Landsat-scale Change\nDetection Method", #add custom title for the legend
                    breaks=c("BFAST", "CCDC", "EWMA", "LandTrendr", "VCT", "VeRDET"), #groups from the dataset appearing in legend
                    labels=c("BFAST", "CCDC", "EWMA", "LandTrendr", "VCT", "VeRDET"), #labels appearing in legend
                    values = c("BFAST"= "gray20", "CCDC" = "red", "EWMA" = "darkorchid3", 
                               "LandTrendr" = "mediumseagreen", "VCT"= "dodgerblue3", "VeRDET"= "chocolate2"))+ #set colors of bars manually
  scale_y_continuous(limits = c(0, 100)) #set y-axis limits 

#Line graph for continous data across time, different colors and line types
#Emily Mills 9/20/17.
#This was a graph not included in the Change Detection Final report,
#designed to visualize percent overlap (regular and fuzzy) of different change detection methods
#with a reference dataset- here Impervious Surface Gain from 1985-2008.

#set working directory to project directory/folder where data resides
setwd("X:/GIS/CBP_Change_Detection/Scripts/CompGraphs_GFC_ImpGain")

#load ggplot2 graphing package
library(ggplot2)

#read in data and print to make sure it looks right
imp<- read.csv("Imp_Comp.csv", header=TRUE)
print(imp)

#set colors to be used for each level of interest (here, change detection method)
group.colors <- c(CCDC = "red", CCDCF = "red", VCT = "blue2", VCTF = "blue2", LandTrendr= "green4" , 
                  LandTrendrF= "green4", EWMA = "darkorchid1", EWMAF = "darkorchid1",
                  VeRDET = "chocolate2", VeRDETF = "chocolate2")

#set line types to be used for each level of interest (here, fuzzy or regular overlap)
line.types<- rep(c("solid", "dotted"), 5)

#format the graph

ggplot(data=imp, aes(x=year, y=PCD, group = Method, linetype= Method, color= Method) ) +
  geom_line(size = 1.1) + #sets width of line
  geom_point() + #adds points at the data points
  scale_linetype_manual(values = line.types) + #applies the line types specified above
  scale_color_manual(values= group.colors)+ #applies group colors specified above
  labs(x= "Year", y= "Percent of Annual Impervious Gain Detected")+ #add custom label text for each axis
  scale_x_continuous( name= "Year", breaks = c(1985:2008), labels= c("1985", "1986", "1987", "1988", "1989", "1990",
    "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008"))+
  #customize axis breaks and labels
  theme_classic()+ #choose a graph theme
  theme(axis.title = element_text(face = "bold", color = "black", size = 28), #format text of axis titles
        axis.text.x = element_text(color= "black", size = 18, margin=margin(b=20)), #format text of axis labels. margin controls spacing from axis
        axis.text.y = element_text(color="black", size = 22, margin=margin(l=10)), #format text of axis labels. margin controls spacing from axis
        legend.text = element_text(size = 20), #format legend text
        legend.title = element_text(face = "bold", size = 26), #format legend title
        legend.key.size = unit(1.75, 'lines')) #format line spacing in legend

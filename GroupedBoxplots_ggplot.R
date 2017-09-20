#Boxplots for continuous data
#Emily Mills 9/20/17.
#This script creates boxplots, visualizing the distribution of percent of pixels overlapping with a an annual reference dataset
#(here- Global Forest Loss by Hansen) over a range of years 2001-2014



#set working directory to project directory/folder where data resides
setwd("X:/GIS/CBP_Change_Detection/Scripts/CompGraphs_GFC_ImpGain")

#load ggplot2 graphing package
library(ggplot2)



#read in data and print to make sure it looks right
PCD<- read.csv("GFC_Comp.csv", header=TRUE)
print(PCD)

#add a new column as a label for the boxplots (here-whether the overlap was normal or fuzzy/offset: +/- yr considered accurate)
#(This step can be done before reading in the data, in Excel for example.)
PCD$Fuzz<- ifelse(PCD$fuzzy ==0, "Normal", "Offset")

#set colors to be used for each level of interest (here, change detection method)
group.colors <- c(CCDC = "red", CCDCF = "red", VCT = "dodgerblue3", VCTF = "dodgerblue3", LandTrendr= "mediumseagreen" , 
                  LandTrendrF= "mediumseagreen", EWMA = "darkorchid3", EWMAF = "darkorchid3", BFAST = "gray30", BFASTF = "gray30",
                  VeRDET = "chocolate2", VeRDETF = "chocolate2")



#boxplots GFC
#format graph

ggplot(data= PCD, aes(x = Fuzz, y= PCD, fill=Method))+ #aes set x and y variables, fill= by different change detection methods
  geom_boxplot()+ #add boxes
  scale_fill_manual(values= group.colors)+ #set colors of bars manually to the ones specified in object 'group.colors' above
  labs(y= "Percent of Annual Forest Loss Detected", title = "Change Detection Method")+ #add custom label text for each axis and title(top label in this case)
  facet_grid(~meth)+ #add group labels stored in variable 'meth' across the top of the graph
  theme_classic()+ #choose a graph theme
  theme(plot.title = element_text(face = "bold", color = "black", size = 20, hjust= 0.5),  #format text of plot title (top label here)
        axis.title.y = element_text(face = "bold", color = "black", size = 24),  #format text of axis titles
        axis.title.x = element_blank(), #remove x-axis title
        axis.text.x = element_text(color= "black", size = 20, angle = 60, hjust = .9, vjust = .9, margin=margin(b=20)), #format text of axis labels. 
        #angle= tilts axis labels for readability. hjust and vjust used to adjust position of labels horizontally and vertically respectively.
        axis.text.y = element_text(color="black", size = 20, margin=margin(l=10)), #format text of axis labels. margin controls spacing from axis
        legend.position = "none", #remove legend
        strip.text.x = element_text(face = "bold", color = "black", size = 20))+ #format top label text (in facet_grid command)
  scale_y_continuous(limits = c(0,100)) #set y-axis limits 

#Stacked and grouped bar graph for continous data
#Emily Mills 9/20/17.
#This script creates a stacked and grouped bar graph, visualizing percent of pixels in confusion matrix categories
#of different change detection methods with different reference datasets

#set working directory to project directory/folder where data resides
setwd("X:/GIS/CBP_Change_Detection/Scripts/CompGraphs_GFC_ImpGain")

#load ggplot2 graphing package
library(ggplot2)



#read in data and print to make sure it looks right
acc1<- read.csv("StackedAcc.csv")
print(acc1)

#add a new column to determine order of reference data sets groups (A-D)
#(This step can be done before reading in the data, in Excel for example.)
acc1$ref<-ifelse(acc1$Ref == "GFC", "C",
                 ifelse(acc1$Ref == "Imp", "D",
                        ifelse(acc1$Ref == "HR", "A", "B"))) 
acc1$ref <- as.factor(acc1$ref) #ensure this variable is of type factor (with 4 levels)

#order the dataframe by column "Ord" the desired order that the bars will be stacked (bottom to top)
acc1 <- acc1[order(acc1$Ord),]  
 

#set up labeller function, which will tell the graph which label to substitute for the 'ref' column value 
ref_names <- list(
  'A'="High Resolution",
  'B'="NLCD",
  'C'= "Forest Loss",
  'D'="Impervious Gain"
)
ref_labeller<- function(variable, value){
  return(ref_names[value])
}


#Stacked Accuracy/Errors of commission and ommission
#format graph

ggplot(data=acc1, aes(x= Method, y= E_Com, group = Method, fill = as.factor(Ord))) + #aes set x and y variables, and grouping variable that will appear in legend.
            #fill= by different confusion matrix categories
  geom_bar(color = "black", stat="identity", width = .8) + #add bars- color=outline color, width=bar width
  labs(x = "Change Detection Method", y = "Percent of Pixels (%)", title = "Reference data set")+ #add custom label text for each axis and title(top label in this case)
  facet_grid(~ref, labeller= ref_labeller)+ #add group labels across the top of the graph according to the labeller function set up above
  scale_fill_manual(name = "Confusion Matrix\nCategories", #add custom title for the legend
                    labels = c("Change Agreement", "Commission Error", "Omission Error", "No Change Agreement"), #labels appearing in legend
                    values = c("gray13",  "#1f78b4", "#ff7f00", "gray65"), #set colors of bars manually
                    guide=guide_legend(reverse=T)) + #reverse order of items in legend so they match intuitively with the graph
  
  theme_classic()+ #choose a graph theme
  theme(plot.title = element_text(face = "bold", color = "black", size = 20, hjust= 0.5), #format text of plot title (top label here)
        axis.title = element_text(face = "bold", color = "black", size = 28), #format text of axis titles
        axis.text.x = element_text(color= "black", size = 20, angle = 60, hjust = .9, vjust = 0.9, margin=margin(b=20)), #format text of axis labels. 
                  #angle= tilts axis labels for readability. hjust and vjust used to adjust position of labels horizontally and vertically respectively.
        axis.text.y = element_text(color="black", size = 22, margin=margin(l=10)), #format text of axis labels. margin controls spacing from axis
        legend.title = element_text(face = "bold", color= "black", size = 26), #format legend title
        legend.text = element_text(color= "black", size = 20), #format legend text
        strip.text.x = element_text(face = "bold", color = "black", size = 20), #format top label text (in facet_grid command)
        legend.key.size = unit(2, 'lines')) + #format line spacing in legend
  scale_y_continuous(limits = c(0,101)) #set y-axis limits 

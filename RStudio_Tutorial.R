#RStudio Tutorial
#Emily Mills
#Mon Oct. 2, 2017


### I. Intro Stuff

#set working directory for your project, parent folder
#note forward slashes for path names
#can also do in GUI:
#Session-->Set Working Directory-->Choose Directory. navigate to parent folder.

setwd("C:/Users/EMills/Desktop/RStudio_Tutorial")

getwd()

#install and call packages you'll use in your script
#can also do this in the packages tab, bottom right window
install.packages()

library(ggplot2)
#or
require()


###################################################################################################


### II. Basics of R language, syntax

#assigning variables

myphrase<- "Hello World!"
print(myphrase)
#R is case sensitive--no typos please!
print(Myphrase)


#classes or basic datatypes
#characters
character<- "text goes in quotes"
add<- "just like python"
sentence<-paste(character, add, sep = "-")

nchar(sentence)
toupper(sentence)
substr(sentence, 14, nchar(sentence))


#numbers
numeric<- 3.141592653589793
integer<- 5
integer<- as.integer(5)
#overwriting variables

numchar<- as.character(5)
logical<- integer<numeric

#check your datatype
typeof(integer)
#or
class(logical)


#combine/concatenate- use c()
alpha<- c("a", "b", "c", "d")
numbers<- c(1, 2, 3, 4)
num1<- 1:10
#can use : instead of c for consecutive numbers. always need a c for nonconsecutive
num2<- c(1, 10)
even<- seq(2, 100, 2)


###################################################################################################


### III. Vectors, Lists, Matrices, and Data frames... Oh my!

#vectors
#vector = a sequence of data elements of the same basic type.list = generic vector containing other objects
#for example concatenated strings, or numbers (above)
#reference an item in a vector
alpha[3]
#note indices start at 1 in R, unlike python!


#lists
#list = a vector containing other objects. a vector of vectors
mylist<- list(alpha, numbers, even)
#reference a vector within a list
mylist[2]
mylist[c(1,3)]
#reference an item within a vector within a list
mylist[[2]][3]


#matrices
#matrix = a collection of data elements of the same type arranged in a two-dimensional rectangular layout.
A <- matrix( c(2, 4, 3, 1, 5, 7), # the data elements 
     nrow=2,              # number of rows 
     ncol=3,              # number of columns 
     byrow = TRUE)        # fill matrix by rows 
print(A)
#reference an item in a matrix
A[2,3]
#R always does rows first then columns


#dataframes
#data frame= stores a data table. added functionality to a matrix: data elements can be different types and
#can add column and row names.


#let's make some data
names<-c("Rachel","Jake","Mike","Louis","Cass","Emily","David")
sibs<- c(2,2,2,2,1,2,1)
cousins<- c(2,9,13,11,10,4,9)
carcolor<- c("silver","silver","silver","gray","red","red","charcoal")

#make a dataframe from columns we made
mydf<- as.data.frame(cbind(names, sibs, cousins, carcolor))
#examine our work
print(mydf)
head(mydf)
tail(mydf)
names(mydf)
dim(mydf)

#change column labels
colnames(mydf)
rownames(mydf)
colnames(mydf)<- c("Names", "Sibs", "Cousins", "Car_Color")
colnames(mydf)[2]<- "Siblings"

#command to flip rows and columns?
t(mydf)

#reference parts of a dataframe
#Again R always references [row, column]. Must have comma and blank if you want all rows/columns.
#give me rows 1-4, all columns
mydf[1:4, ]
#give me all rows, columns 1 and 4
mydf[ , c(1,4)]
#give me everything except column 1
mydf[ , -1]
#negative indexing does not work in R, like it does in python. '-' in R means 'exclude'


###################################################################################################

### IV. Workspace

#let's check out our workspace environment now, see all of our variables we created
#can open tables and data directly in RStudio if you don't want to use print
ls()
#lists objects in your current workspace
rm(mydf)
#removes objects from your workspace
#can also clear entire workspace with the broom icon in Environment window


###################################################################################################


### V. Importing and working with data

#import a larger dataset from an already existing file
gpteeth<-read.csv("Docs/gpteeth.csv", header=TRUE)
#could put the whole path in here, but since we setwd(), we can start from there.

gpteeth
#this dataset is titled "The Effect of Vitamin C on Tooth Growth in Guinea Pigs"
#The response (len) is the length of odontoblasts (cells responsible for tooth growth) in 62 guinea pigs numbered by X.
#Each animal received one of three dose levels of vitamin C (0.5, 1, and 2 mg/day) by one of two delivery methods,
#(orange juice or ascorbic acid (a form of vitamin C and coded as VC).

#A data frame with 62 observations on 3 variables.
#[,1]	len	numeric	Tooth length
#[,2]	supp	factor	Supplement type (VC or OJ).
#[,3]	dose	numeric	Dose in milligrams/day

summary(gpteeth)

#use dollar sign to reference a column in a dataframe by name
#some statistics
mean(gpteeth$len)
median(gpteeth$len)
range(gpteeth$len)
sd(gpteeth$len)
var(gpteeth$len)

min(gpteeth$dose)
max(gpteeth$dose)

#remove rows with NA
is.na(gpteeth$len)
gpteeth<- na.omit(gpteeth)
gpteeth

#write a csv
write.csv(gpteeth, "Docs/gpteeth_noNA.csv")

#query rows
gpteeth[gpteeth$len > 30, ]
gpteeth[which(gpteeth$len > 30), ]

megatooth<- gpteeth[gpteeth$len > 30, 2:4]
megatooth<- gpteeth[gpteeth$len > 30, c("len", "dose")]

#calculate a new column for teeth length in inches
gpteeth$len_in<- gpteeth$len * 0.0393701

#set a new column for category of tooth length
gpteeth$cat<- ifelse(gpteeth$len >= 30, "huge",
                     ifelse(gpteeth$len >= 20 & gpteeth$len <30, "large",
                            ifelse(gpteeth$len >= 10 & gpteeth$len <20, "medium", "small")))


#subset
?subset
longesttooth<-subset(gpteeth, len == max(len))
len<= len>= leng==
shortesttooth<-subset(gpteeth, len == min(len), "len")
expsetup<- subset(gpteeth, , 3:4)
expsetup<- subset(gpteeth, select = 3:4)

#Note on calling functions
#argument order- don't have to specify arguments for very basic functions, R uses positional matching
#you might want to use exact name matching for functions with many and/or less commonly used arguments

#table builds table of counts of each combination of factor levels
table(gpteeth$dose)
table(gpteeth$supp, gpteeth$dose)


###################################################################################################


### V. Create your own functions
#creating your own functions


#basic for loop
for (year in 2010:2015){
  print(paste("The year is", year))
}


#loop through files to make a list
rasterlist<- list()
mypath<- "X:/GIS/CBP_Change_Detection/_Data/Impervious/ImpFiltered/"
count<- 0

for (x in 2:25){
  raster<- paste(mypath, "impgain", as.character(year), ".tif", sep="")
  count<- count+1
  rasterlist[[count]]<- raster
}
rasterlist

z<-mean(x=1:10)
z <- mean(x<-1:10)
#use <- for assigning variables.

#differences with python: parentheses after the 'for', {} instead of ':'

for (i in length(gpteeth$X)){
  print(paste("Guinea pig", gpteeth$X, "has", gpteeth$cat, "teeth"))
}


#while loops
#similar to a for loop, but it tests an initial expression,
#only carries out the body of the loop if the test expression is true

#basic while loop
i<- 1
while (i < 6) {
  print(i)
  i = i+1
}


###################################################################################################


### VI. Graphs in R

#simple graphs

#scatterplot
plot(gpteeth$len, gpteeth$len_in, xlab= "Length(mm)", ylab = "Length(in)")
?par
#add axis labels:  xlab= "Length(mm)", ylab = "Length(in)"

#histogram
hist(gpteeth$len, xlab = "Tooth Length(mm)", ylab= "Frequency", main = "Histogram of guinea pig tooth length", ylim = c(0,14))

#customize axis limits: ylim = c(0,14)

#barplots
bardata <- aggregate(gpteeth["len"], by=gpteeth[c("supp","dose")], FUN=mean)
bardata <- bardata[order(bardata$supp),]
bardata$dose<- as.factor(bardata$dose)


p<- ggplot(bardata, aes(supp, len))

p + geom_bar(aes(fill=as.factor(dose)), position = "dodge", stat= "identity", width= 0.7)

p + geom_bar(aes(fill=as.factor(dose)), position = "dodge", stat= "identity", width = 0.7) +
        labs(x="Type of Supplement", y=("Tooth Length (mm)")) +
  
  theme(axis.title = element_text(color= "black", size= "20"), axis.text = element_text(color = "black", size = "14"),
        legend.title= element_text(color= "black", size= "20"), legend.text = element_text(color = "black", size = "14")) +
      
  scale_fill_manual(name= "Dose", values= c("gray70",  "gray40", "gray10"))

#export R plots/images



###################################################################################################


### VII. FUTURE RESOURCES


###some cool packages:

##Basics
#ggplot2- graphs
#RColorBrewer- color palettes
#dplyr-data manipulation, multi-step workflows
#psych package describe()
#stringr- common string operations
#lubridate- deal with dates and times

##GIS packages
#sp- spatial data functions
#raster- raster data functions
#rgdal- Provides bindings to the Geospatial Data Abstraction Library ('GDAL')
#RStoolbox- remote sensing package

##Statistical packages
#Cluster
#nlme
#Lme4
#zoo-deal with time series data

##Development
#Git2r
#Devtools



###The Future of R:

##Shiny apps
#https://shiny.rstudio.com/

##Developers/Sharing Code- R Markdown and Github

##R-Arc bridge- great for manipulating data tables of spatial data- attribute tables, joins etc.



###Links to check out for more resources:

#https://www.rstudio.com/online-learning/
#https://www.rstudio.com/resources/cheatsheets/
#Use stack exchange!


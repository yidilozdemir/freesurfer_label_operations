library(readr)
library(dplyr)

#subject is the first subject to be compared against, which subject is the first one doesn't really matter as we will only visualize values >1 in freesurfer (meaning two labels had that coordinate, at least), 
#other subjects are in label_name_list

subject <- "bert"
label_name_list <- c("X", "Y", "Z"  )

# TODO : I will do apply instead of these for

#For my specific purposes; I have three different methods for areas 1 to 3. If you have just one ROI ex."aips" 
#you do not need for loops, just change line 17 and line 25
for (method in c("manual", "benson", "ros"))
{
  for (area in 1:3) {
  label_path <- paste("~/local/", subject, area, method , "/label", sep = "")
  label <- read_delim(label_path, delim = "  ", col_names = FALSE, skip = 2) %>% select (X1,X2,X3,X5,X7,X8) %>% unnest()     label$X2 <- 1:length(label$X1) #to keep track of rows
  names(label) <- c("ascii", "num", "coord1", "coord2", "coord3", "value")

#first start with one file, then with apply check every ascii coordinates, if between two
# files the coordinates match increase the value by one, freesurfer can color these values differently
#and update the label in each run 
  label_join <- function (other_subject){
  new_label_name <- paste("~/local/", other_subject,area, method, "/label", sep = "")
  new_label_compare <- read_delim(new_label_name, delim = "  ", col_names = FALSE, skip = 2) %>% select (X1,X2,X3,X5,X7,X8) %>% unnest()
  new_label_compare$X2 <- 1:length(new_label_compare$X1) #to keep track of rows
  names(new_label_compare) <- c("ascii", "num", "coord1", "coord2", "coord3", "value")
  
  #this finds the row where the ascii code matches the ascii of the looped label's ascii value, then uses that row number to update the label's value to +1 
  go_over_points <- function(x) {
   row_matched <- label %>% unnest() %>% filter (ascii == new_label_compare$ascii[x]) %>% select(num)
   label$value[row_matched] <- (label$value[row_matched] + 1)
    }
  sapply(as.numeric(1:length(label$ascii)), FUN = go_over_points)
}
apply(label_name_list, FUN = label_join)

final_label <- paste(area, "_", method, "_conjunction_label", sep = "")

#this saves the final label 
write.csv(label, final_label)
}
}

#leftovers
#label <- label %>% filter(ascii == new_label_compare$ascii[x]) %>% mutate(value = value + 1)
#label_try <-  label %>% mutate(value == case_when(new_label_compare$ascii[x] %in% ascii ~ (value + 1), FALSE ~ value)) 
#if (label$ascii[x] ==  new_label_compare$ascii[x]) { label$value[x] <- (label$value[x] + 1) } else {label$value[x] <- label$value[x]}
#print(x)

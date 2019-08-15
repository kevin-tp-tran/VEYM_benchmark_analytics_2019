# Kevin Tran
# June 25, 2019
# VEYM Benchmark Data - National Report

# Clears the global environment ------------------------------------------------
rm(list=ls())

# Text File entry --------------------------------------------------------------
# Requires three text files: answers, answers of students per question, and 
# scores of students per question. The data files for the student's answers and 
# scores must start in column 4.
# C:\\Users\\kevint24\\Documents\\Project\\VEYM_benchmark_analytics_2019\\Data\\TN\\TN.C3.letters.txt
# C:\\Users\\kevint24\\Documents\\Project\\VEYM_benchmark_analytics_2019\\Data\\TN\\TN.C3.numbers.txt
# C:\\Users\\kevint24\\Documents\\Project\\VEYM_benchmark_analytics_2019\\Data\\TN\\TN.C3.answers.txt
#
letters_entry <- readline(prompt = "Letter responses input path for test: ")
numbers_entry <- readline(prompt = "Question scores input path for test: ")
answers_entry <- readline(prompt = "Answers input path for test: ")
name <- readline(prompt = "Class name and division for test: ")

# Section  entries -------------------------------------------------------------
# Prompts the user to input the amount of sections, the section overview, and 
# the amount of questions per section. The user must input this data 
# chronologically.
#
section_names <- c()
section_count <- c()
sections <- as.numeric(readline("Number of sections in this test: "))
for (i in 1:sections) {
  category_name <- readline("Section name: ")
  category_count <- readline("Questions pertaining to this category: ")
  section_names <- append(category_name, section_names)
  section_count <- append(as.numeric(category_count), section_count)
}
section_names <- rev(section_names)
section_count <- rev(section_count)

# Saving plots in pdf ----------------------------------------------------------
# Sets the name and destination of the file for all data visualization plots.
# C:\\Users\\kevint24\\Documents\\Project\\VEYM_benchmark_analytics_2019\\Visualization
#
setwd(readline("What is the output path of your file? "))
pdf(readline("What is the name of your pdf? "))

# Initializing text files ------------------------------------------------------
# Takes the inputted text files and initializes them as objects.
#
dat <- read.table(letters_entry, header = T, fill = TRUE)
dat_numbers <- read.table(numbers_entry, header = T, fill = TRUE)
answers <- read.table(answers_entry, header = T, fill = TRUE)
questions <- ncol(answers)
students <- nrow(dat)

# Overall Test Statistics ------------------------------------------------------
# Creates a histogram and boxplot of the overall test in addition to
# identifying the 5-number summary.
#
par(mfrow = c(1,2))
summ <- as.numeric(unlist(dat[3])) / questions
hist(summ, main = paste("Histogram of", name, sep = " "), xlab = "Percentages")
abline(v = mean(summ),col = "#FF0000")
statist = c(summary(summ), sd(summ))
print(statist)
boxplot(summ, main = paste("Boxplot of the scores for", name, sep = " "))

# Sectional Statistical Data ---------------------------------------------------
# Makes a histogram and boxplot of all the sections
#
par(mfrow = c(3,2))
n.trials <- seq(from = 4, to = questions + 3, by = 1)
range <- c(4, 4+section_count[1]-1)
for (j in 1:sections) {
  section_scores <- c()
  for (i in 1:students) {
    section_scores <- append(sum(dat_numbers[i, range[1]:range[2]]),
                             section_scores)
  }
  hist(section_scores, col = c("#009999"), main = 
       paste("Histogram of", section_names[j], sep = " "), 
       xlab = paste("Scores of", section_names[j], sep = " "))
  boxplot(section_scores, main = 
          paste("Boxplot of", section_names[j], sep = " "))
  range[1] <- range[1] + section_count[j]
  range[2] <- range[2] + section_count[j+1]
}

# Individual Question Visualization --------------------------------------------
# Creates a histogram for every question with the correct answer colored in as
# green and the others colored in as red.
#
par(mfrow = c(3, 3))
entries <- 0
for (i in n.trials) {
  # utf8ToInt("A") = 65, to get index 1, we subtract off 64
  cols <- c("#FF0000", "#FF0000", "#FF0000", "#FF0000", "#FF0000",
            "#FF0000", "#FF0000")
  if (nchar(as.character(answers[1, i - 3])) > 1) {
    index <- utf8ToInt(substr(as.character(answers[1, i - 3]), 0, 1)) - 64 + 1
    cols <- append(cols, "#FF0000")
  }  else {
    index <- utf8ToInt(as.character(answers[1, i - 3])) - 64
  }
  cols[index] <- "#7CFC00"
  barplot(prop.table(table(dat[i])), main = paste("Question", i - 3, sep = " "),
          col = cols, ylab = "Percentage")
  new_entry <- data.frame(i - 3, prop.table(table(dat[i]))[index])
  names(new_entry) <- c("Question", "% Correct")
  entries <- rbind(entries, new_entry)
}

# Individual Question Summary Visualization ------------------------------------
# Plots the percentages correct of every question as a barplot and a plot.
#
par(mfrow = c(1,1))
entries2 <- entries
entries2[2] <- round(entries[2] * 10) / 10
barplot(table(entries2), main = "Barplot of Question Correct Percentages",
        space = 0, col = "lightblue", xlab = "% Correct",
        ylab = "Count of Questions")
summary(unlist(entries[2]))
plot(unlist(entries[1]), unlist(entries[2]), xlab = "Question Number",
     ylab = "% Correct", main = "Plot of Question Correct Percentages")

# Closing pdf ------------------------------------------------------------------
# Closes the pdf and saves the pdf with the inputted data plots.
#
dev.off()

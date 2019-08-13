# Kevin Tran
# June 25, 2019
# VEYM Benchmark Data - National Report

### Clears the global environment
rm(list=ls())

### User entry for data analysis
## Text File entry
# Requires three text files: answers, answers of students per question, and scores of students per question
# C:\\Users\\kevint24\\Documents\\Project\\VEYM_benchmark_analytics_2019\\Data\\AN\\AN.C1.letters.txt
dat_letters_entry = readline(prompt = "What is the file path of the test scores with letters as entries: ")
# C:\\Users\\kevint24\\Documents\\Project\\VEYM_benchmark_analytics_2019\\Data\\AN\\AN.C1.numbers.txt
dat_numbers_entry = readline(prompt = "What is the file path of the test scores with numbers as entries: ")
# C:\\Users\\kevint24\\Documents\\Project\\VEYM_benchmark_analytics_2019\\Data\\AN\\AN.C1.answers.txt
answers_entry = readline(prompt = "What is the file path of the test score letter answers: ")
name = readline(prompt = "Enter the test nganh and cap pertaining to the test: ")

## Section category entries
# Prompts the user to input the amount of categories, the category names, and the
# amount of questions per category/section. The user must input this data chronologically.
section_names <- c()
section_count <- c()
categories = as.numeric(readline("How many sections are there? "))
for (i in 1:categories) {
  category_name = readline("What is the category name? ")
  category_count = as.numeric(readline("How many questions pertain to this category? "))
  section_names = append(category_name, section_names)
  section_count = append(category_count, section_count)
}
section_names = rev(section_names)
section_count = rev(section_count)

# Setting a document location and name for the plots and graphs from the code
# Input: File directory location
setwd(readline("Where would you like to store your file? "))
# Input: File name
pdf(readline("What would you like the pdf to be called? "))

# Initializes the text files as tables and variables
dat = read.table(dat_letters_entry, header = T, fill = TRUE)
dat_numbers = read.table(dat_numbers_entry, header = T, fill = TRUE)
answers = read.table(answers_entry, header = T, fill = TRUE)
questions = ncol(answers)
students = nrow(dat)

### Overall Statistical Data
par(mfrow = c(1,2))
summ <- as.numeric(unlist(dat[2])) / questions
# Histogram and mean of the overall test
hist(summ, main = paste("Histogram of", name, sep = " "), xlab = "Percentages")
abline(v=mean(summ),col="#FF0000")
# Boxplot data of overall scores
statist = c(summary(summ), sd(summ))
print(statist)
boxplot(summ, main = paste("Boxplot of the test for", name, sep = " "))

## Sectional Statistical Data
par(mfrow = c(3,4))
# Returns how much 1 student got for a section
n.trials = seq(from = 4, to = questions + 3, by = 1)
range = c(4, 4+section_count[1]-1)
for (j in 1:categories) {
  section_scores = c()
  for (i in 1:students) {
    section_scores = append(sum(dat_numbers[i, range[1]:range[2]]), section_scores)
  }
  hist(section_scores, col=c("#009999"), main = paste("Histogram of", section_names[j], sep = " "),
       xlab = paste("Scores of", section_names[j], sep = " "))
  boxplot(section_scores, main = paste("Boxplot of", section_names[j], sep = " "))
  range[1] = range[1] + section_count[j]
  range[2] = range[2] + section_count[j+1]
}

## Question Statistical Data
# Individual Answer Histograms - completed
par(mfrow = c(3, 3))
entries = 0
for (i in n.trials) {
  # utf8ToInt("A") = 65, want index 1 for it
  index <- utf8ToInt(as.character(answers[1, i-3])) - 64
  cols = c("#FF0000", "#FF0000", "#FF0000", "#FF0000", "#FF0000", "#FF0000", "#FF0000")
  cols[index] = "#7CFC00"
  barplot(prop.table(table(dat[i])), main = paste("Question", i-3, sep = " "), col=cols)
  new_entry <- data.frame(i-3, prop.table(table(dat[i]))[index])
  names(new_entry) <- c("Question", "% Correct")
  entries = rbind(entries, new_entry)
}

## Percentage of questions correct and individual plot of how the percentage of questions
par(mfrow = c(1,1))
barplot(table(entries), main = "Histogram of % Correct of Questions")
summary(unlist(entries[2]))
plot(unlist(entries[1]), unlist(entries[2]), xlab = "Question", ylab = "% Correct", 
     main = "Plot of Question and % Correct")

# Closes off the saving the pdf
dev.off()

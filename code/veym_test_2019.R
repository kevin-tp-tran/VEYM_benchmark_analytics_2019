# Kevin Tran
# June 25, 2019
# VEYM Benchmark Data - National Report

# Resetting --------------------------------------------------------------------
# Clears the global environment and closes any file connections that are
# open. 
rm(list=ls())
sink()
dev.off()

# Text File Entry --------------------------------------------------------------
# Requires three text files: answers, answers of students per question, and 
# scores of students per question for the whole nation. The data files for the
# student's answers and question 1 must start in column 4.
# C:\\Users\\kevint24\\Documents\\Project\\VEYM_benchmark_analytics_2019\\Data\\AN\\AN.C1.letters.txt
# C:\\Users\\kevint24\\Documents\\Project\\VEYM_benchmark_analytics_2019\\Data\\AN\\AN.C1.numbers.txt
# C:\\Users\\kevint24\\Documents\\Project\\VEYM_benchmark_analytics_2019\\Data\\AN\\AN.C1.answers.txt
# E:\\Coding\\VEYM_benchmark_analytics_2019\\Data\\HS\\HS.C2.letters.txt
# E:\\Coding\\VEYM_benchmark_analytics_2019\\Data\\HS\\HS.C2.numbers.txt
# E:\\Coding\\VEYM_benchmark_analytics_2019\\Data\\HS\\HS.C2.answers.txt
#
letters_entry <- readline(prompt = "Letter responses input path for test: ")
numbers_entry <- readline(prompt = "Question scores input path for test: ")
answers_entry <- readline(prompt = "Answers input path for test: ")
test_name <- readline(prompt = "Class name and division for test: ")

# Section  entries -------------------------------------------------------------
# Prompts the user to input the amount of sections, the section overview, and 
# the amount of questions per section. The user must input this data 
# chronologically.
#
section_names <- c()
section_count <- c()
sections <- as.numeric(readline("Number of sections in this test: "))
for (indiv_sect in 1:sections) {
  category_name <- readline("Section name: ")
  category_count <- readline("Questions pertaining to this category: ")
  section_names <- append(category_name, section_names)
  section_count <- append(as.numeric(category_count), section_count)
}
section_names <- rev(section_names)
section_count <- rev(section_count)

# Setting Directory ------------------------------------------------------------
# Sets the directory where all of the files will be placed once running the 
# function.
# C:\\Users\\kevint24\\Documents\\Project\\VEYM_benchmark_analytics_2019\\Visualization\\test\\anc1
# E:\\Coding\\VEYM_benchmark_analytics_2019\\Visualization\\Test\\anc1\\making
#
setwd(readline("What is the output path of your file? "))

# test_analysis function -------------------------------------------------------
# Makes a pdf of graphs depicting relation and analytics of the test for the 
# given amount of students. In addition, a txt file is made with the analytics
# of the graphs such as 5-number summary, frequency of scores, etc.
#
test_analysis <- function(dat, dat_numbers, doan) {

  # Filing ---------------------------------------------------------------------
  # Sets the name and destination of the file for all data visualization and
  # analytics. Also updates the number of students depending on which chapter/
  # nation analyzing.
  #
  file_name <- paste(tolower(substring(test_name, 1, 2)), "c",
                     toString(sum(charToRaw(tolower(test_name)) == charToRaw('i'))),
                     sep = "")
  pdf(paste(doan, "_graphs_", file_name, ".pdf", sep = ""))
  sink(paste(doan, "_analytics_", file_name, ".doc", sep = ""))
  students <- nrow(dat)
  
  # Introduction ---------------------------------------------------------------
  # Titles the txt file with a test summary portion depicting number of
  # questions and students
  #
  cat("Test Summary for", test_name, "\n")
  cat("----------------------------------------------", "\n")
  cat("Number of questions = ", questions, "\n", sep = "")
  cat("Number of students = ", students, "\n \n", sep = "")
  
  # If there is only one student, then the qqnorm does not run because there
  # is no histogram trend to compare to a distribution.
  #
  # Q-Q Plot 
  # if (students != 1) {
  #   # Q-Q Plot
  #   par(mfrow = c(1,1))
  #   qqnorm(percentages, cex = 0.5, xlab = "Normal Distribution",
  #          ylab = "Test Quantiles")
  #   abline(mean(percentages), sd(percentages))
  #   legend('topleft', c(paste('Mean =', round(mean(percentages), 2)), 
  #                       paste('SD =', round(sd(percentages), 2))), 
  #          text.col = c('black', 'red'), bty = 'n')
  # }
  
  # Sectional Statistical Data -------------------------------------------------
  # Makes a histogram and boxplot of all the sections in the pdf file.
  # Records down the count of scores for the sections and states the questions
  # the section overarches in the txt file.
  #
  cat("Section Summary", "\n")
  cat("----------------------------------------------", "\n")
  cat("Key: The 1st row of the table are the scores & the 2nd row are the frequency.\n\n")
  par(mfrow = c(3,4))
  section_scores <- matrix(0L, nrow = students, ncol = sections)
  colnames(section_scores) <- section_names
  rownames(section_scores) <- dat$Student_ID
  section_scores <- as.table(section_scores)
  n.trials <- seq(from = 4, to = questions + 3, by = 1)
  range <- c(4, 4+section_count[1]-1)
  for (section in 1:sections) {
    for (student in 1:students) {
      section_scores[student, section] <- 
        sum(dat_numbers[student, range[1]:range[2]])
    }
    hist(section_scores[, section], col = c("#009999"), main = 
           paste(section_names[section], "\nSection"), 
         xlab = paste(section_names[section], "Scores", sep = "\n"))
    boxplot(section_scores[, section], ylab = "Section Scores", main = 
              paste(section_names[section], "\nSection"))
    cat("Scores of", section_names[section], "from lowest to highest:")
    print(table(section_scores[, section]))
    cat("Score calculated from questions ", range[1] - 3, " to ", range[2] - 2,
        ".\n", sep = "")
    cat("The average score for this section is ", 
        round(mean(section_scores[, section]), 2), ".\n", sep = "")
    if (students != 1) {
      cat("The average spread for this section is ", 
          round(sd(section_scores[, section]), 2), ".\n \n", sep = "")
    }
    range[1] <- range[1] + section_count[section]
    range[2] <- range[2] + section_count[section + 1]
  }
  
  # cat("\nSection Linear Correlation\n")
  # cat("----------------------------------------------", "\n")
  # if (sd(section_scores) != 0) {
  #   print(cor(section_scores))
  # }
  # cat("\n")
  # cat("The above table shows the linear correlation between all sections. \n")
  # cat("Values near zero show there is no correlation, whereas values near one\n")
  # cat("show there is a correlation between the two categorical scores.")
  # cat("\n \n")
  
  # Individual Question Visualization ------------------------------------------
  # Creates a histogram for every question with the correct answer colored in as
  # green and the others colored in as red. Also puts a frequency count of the
  # responses of the students alongside the correct percentage and response
  # answer in a txt file.
  #
  cat("\nIndividual Question Summary \n")
  cat("----------------------------------------------", "\n")
  cat("Key: The 1st row are the responses & the 2nd row are the frequency.\n")
  cat("     X = no responses, O = other from A-E and the correct answer.\n \n")
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
    qst_resp <- table(dat[i])
    barplot(qst_resp, main = paste("Question", i - 3, sep = " "),
            col = cols, xlab = "Answer Responses", ylab = "Frequency")
    cat("Count of answer responses for question ", i - 3, ":", sep = "")
    print.table(qst_resp)
    cat("The correct answer is ", toString(answers[1, i-3]), ".\n", sep = "")
    cat("The percentage of students who got this answer correct is ",
        round(prop.table(qst_resp)[index] * 100,digits = 2),"%.\n \n", sep = "")
    new_entry <- data.frame(i - 3, prop.table(table(dat[i]))[index])
    names(new_entry) <- c("Question", "% Correct")
    entries <- rbind(entries, new_entry)
  }
  
  # Overall Test Statistics ----------------------------------------------------
  # Creates a histogram and boxplot of the overall test in the pdf file in 
  # addition to writing the 5-number summary in the txt file.
  #
  par(mfrow = c(2,2))
  percentages <- as.numeric(unlist(dat[3])) / questions
  hist(percentages, main = paste(test_name, "Test Scores"),
       xlab = "Test Scores")
  legend('topright', c(paste('Mean =', round(mean(percentages), 2)), 
                       paste('SD =', round(sd(percentages), 2))), 
         text.col = c('red', 'black'), bg = "White", border = "black")
  if (students != 1) {
    abline(v = mean(percentages),col = "#FF0000")
  }
  statist <- c(summary(percentages), sd(percentages))
  rows <- c("Min", "1st Quart.", "Median", "Mean", "3rd Quart.", "Max.",
            "Standard Deviation")
  cat(test_name, "Analytics", "\n")
  for (analytics in 1:length(rows)) {
    cat(rows[analytics], "=", statist[analytics], "\n")
  }
  cat("\n \n")
  boxplot(percentages, main = paste(test_name, "Test Scores", sep = " "),
          ylab = "Test Scores")
  
  # Individual Question Summary Visualization ----------------------------------
  # Plots the percentages correct of every question as a barplot and a plot.
  #
  entries2 <- entries
  entries2[2] <- round(entries[2] * 10) / 10
  barplot(table(entries2), main = "Frequency of Correct Responses",
          space = 0, col = "lightblue", xlab = "Correct Responses",
          ylab = "Frequency")
  summary(unlist(entries[2]))
  plot(unlist(entries[1]), unlist(entries[2]), xlab = "Question Number",
       ylab = "Correct Response", main = "Question vs. Correct\nResponses")
  
  # Closing files --------------------------------------------------------------
  # Closes the files and saves with the inputted sinked txt and the plots in the
  # pdf.
  #
  dev.off()
  sink()
}

# National Analysis ------------------------------------------------------------
# Analyzes the test over all the students and scores.
#
dat_natl <- read.table(letters_entry, header = T, fill = TRUE)
dat_numbers_natl <- read.table(numbers_entry, header = T, fill = TRUE)
answers <- read.table(answers_entry, header = T, fill = TRUE)
students <- nrow(dat_natl)
questions <- ncol(answers)
test_analysis(dat_natl, dat_numbers_natl, "pt")

# Chapter Analysis -------------------------------------------------------------
# Splits up the national test into the different chapter entries and analyzes
# those students to make a txt and pdf file document for chapters.
# Prereq: Table with
dat_numbers2 <- dat_numbers_natl
dat_numbers2[, 1] <- round(dat_numbers_natl[, 1] / 10000000)
chapters <- unique(dat_numbers2[, 1])
indices <- numeric(length(chapters) + 1)
# Find first index of the given chapters
for (i in 1:length(chapters)) {
  indices[i] <- which(dat_numbers2[, 1] == chapters[i])
}
indices[i + 1] <- students  # last index from the national (covers all chapters)
indices
for (i in 1:(length(indices) - 1)) {
  if (i != length(indices) - 1) {
    new_numbers <- dat_numbers2[indices[i]:(indices[i + 1] - 1) ,]
    new_letters <- dat_natl[indices[i]:(indices[i + 1] - 1) ,]
  } else {
    new_numbers <- dat_numbers2[indices[i]:indices[i + 1] ,]
    new_letters <- dat_natl[indices[i]:indices[i + 1] ,]
  }
  doan <- chapters[i]
  test_analysis(new_letters, new_numbers, doan)
}

# Identifying chapters ---------------------------------------------------------
#
chapter_ID <- read.table("E:\\Coding\\VEYM_benchmark_analytics_2019\\Data\\League.Chapters.csv",
                         header = T, fill = TRUE, sep = ",")

# Sorting League of Chapters ---------------------------------------------------
# Sorts through the different chapter entries and puts them into different tables
# 
lien_doan <- c("Thanh Phaolo Hanh", "Joan of Arc", "Saint Benedict",
               "Thanh Gia", "John Paul II", "Thanh Gia", "Ignatius Loyola",
               "Nguon Song", "Ra Khoi", "San Diego", "Sinai", "John Paul II",
               "Daminh Savio", "Joan of Arc")
ld_endpt <- c(15, 29, 50, 55, 56, 62, 73, 87, 99, 103, 110, 129, 139, 140)
ld_endpt
chapters
which(chapters > 3 & chapters < 32)

which(chapters > ld_endpt[1] & chapters < ld_endpt[2])
length(ld_interval)
ld_endpt[1]
typeof(range[1])
typeof(ld_endpt[1])
range <- c(1, ld_endpt[1])
for (i in 1:(length(ld_interval) - 1)) {
  num <- which(chapters > range[1] & chapters < range[2])
  if (length(num) == 1) {
    new_numbers <- dat_numbers2[indices[num]:(indices[num + 1] - 1) ,]
    new_letters <- dat_natl[indices[num]:(indices[num + 1] - 1) ,]
    ld_name <- lien_doan[num]
    # problem because some only have one chapter in different spots (Thanh Gia)
    test_analysis(new_letters, new_numbers, ld_name)
  } else if (length(num) > 1) {
    for (j in num) {
      # combine 2+ chapters into one table for analysis 
    }
  }
  print(num)
  range[1] <- ld_endpt[i]
  range[2] <- ld_endpt[i + 1]
}
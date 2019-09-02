# Reading Visualizations ((chapter\_number)\_(test)\_graphs.pdf)
### Section Breakdoown
For every test, there was either five or six overarching topics tested upon. Within the section breakdown, you will find two graphs per section:
* A histogram of the frequency of scores for the given section
* A boxplot of the division of scores for the given section.

![Section Example](https://github.com/ktptran/VEYM_benchmark_analytics_2019/blob/master/Visualization/Pictures%20for%20README/Section.PNG?raw=true)

### Individual Question Breakdown
The tests ranged from 25-50 questions. All of which had answers as either A, B, C, D, or E. Along with this, there are other responses students could have submitted such as not answering (labeled as an X in graphs), filling in another answer that usually included filling in two options (depicted as O). 

For O, the frequency was only added if the correct answer was not a multi-option answer. As an example, suppose the correct answer is AB. Then, AB would have its own column and O would not include the students who responded AB, A through E, or X, and would instead include all other answers.

For each question, the correct answer is depicted with a lime green and incorrect answers are red.

![Answer Example](https://github.com/ktptran/VEYM_benchmark_analytics_2019/blob/master/Visualization/Pictures%20for%20README/Individual%20Question.PNG?raw=true)

### Overall Test Breakdown
For the overall test breakdown, there are four graphs:

1) In the upper left hand corner, there is a histogram frequency of the test scores. Along with that, there is a red line correlating to the mean which is the average test score. In addition, the standard deviation is listed, which depicts the spread of the data.

![Answer Example](https://github.com/ktptran/VEYM_benchmark_analytics_2019/blob/master/Visualization/Pictures%20for%20README/Individual%20Question.PNG?raw=true)

2) In the upper right hand corner, there is a boxplot depicting the given scores of the section.

![Histogram of Overall Test Scores Example](https://github.com/ktptran/VEYM_benchmark_analytics_2019/blob/master/Visualization/Pictures%20for%20README/Upper%20Left.PNG?raw=true)

3) In the lower left hand corner, there is a barplot showing the frequency of correct responses from the questions. For example, if questions 1-5 all had an overall correct response of 20%, the barplot would have a frequncy of 5 for 0.2.

![Histogram of Test Scores Example](https://github.com/ktptran/VEYM_benchmark_analytics_2019/blob/master/Visualization/Pictures%20for%20README/Lower%20Left.PNG?raw=true)

4) In the lower right hand corner, there is a scatterplot showing the questions vs the percentage of correct responses. This graph is mainly a tool to see if there are any trends or patterns per section or for any correlation between specific questions.

![Scatterplot Example](https://github.com/ktptran/VEYM_benchmark_analytics_2019/blob/master/Visualization/Pictures%20for%20README/Lower%20Right.PNG?raw=true)

# Analytical Files ((chapter\_number)\_(test)\_analytics.doc)
### Test Summary
Within this section, it states the test you are looking at, the number of questions, the students, and the values needed for a boxplot (5-number summary) including the mean and standard deviation.

### Section Summary
The section summary lists out the scores of each section from lowest to highest with the first row of numbers depicting the score and the second row depicting the frequency of those scores. Followed by that, each section states the questions that covered the section along with the average score (mean), and the spread (standard deviation).

### Individual Question Summary
The individual question summary lists out the question number followed by the different responses (first row) and the count of those reponses (second row). Each question is then followed by stating the correct answer and the percentage of students who got the answer correct.

# Statistical Terminologies and Meanings
### Histogram
A histogram will count the frequency of specific values over a certain range (ex: 0-1) from the given data. 

### Boxplot
A boxplot shows the data using 5 main values (referred to as the 5-number summary) and outliers. Using boxplots, you can see the rough estimates of where specific values lie in correlation with each other.
* Outliers: Outliers are depicted using white filled dots with black outlines. These values are observations that lie outside the overall pattern of the data.
* 5-number summary: Within the summary, there is the minimum, 1st quartile, median, 3rd quartile, and maximum.
  * The minimuim is the lowest value from the data
  * The 1st quartile correlates to the value that splits off the lowest 25% of data from the highest 75%
  * The median cuts the data set in half (50% of data)
  * The third quartile splits offhighest 25% of data from the lowest 75%

![Boxplot Example](http://www.comfsm.fm/~dleeling/statistics/boxplot-explained.png)

### Mean and Standard Deviation
The mean is the average value from all of the data values.

The standard deviation is a measure that is used to quantify the amount of variation of a set of data values. A low standard deviation indicates that the data values tend to be closer to the mean, whereas a high standard deviation indicate that the data values are spread out over a wide range of values.

For normal distributed data (which the test scores do show), one standard deviation from the mean sums to 68.27 percent of the set, and two standard deviations from the mean sums to 95.45 percent of the set. This means that for one standard deviation from the mean, 68% of the test scores are within that range, and likewise for two standard deviations with 95%.

![Standard Deviation and Mean](https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Standard_deviation_diagram.svg/330px-Standard_deviation_diagram.svg.png)

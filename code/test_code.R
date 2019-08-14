string <- "AB"
nchar(string)
string.index(1)
substr(string, 0, 1)
substr(string, 2, 3)
utf8ToInt(substr(string, 2, 2)) - 64

if 
# cols <- c("#FF0000", "#FF0000", "#FF0000", "#FF0000", "#FF0000", "#FF0000", "#FF0000")
# if (nchar(as.character(answers[1, i-3])) > 1) {
# index <- utf8ToInt(substr(as.character(answers[1, i-3]), 0, 2)) - 64 + 1
# cols <- append(cols, "#FF0000")
# } else {
# index <- utf8ToInt(as.character(answers[1, i-3])) - 64
# }
# cols[index] <- "#7CFC00"

#merge to form single data set

x_train <- read.table("train/X_train.txt")
x_test <- read.table("test/X_test.txt")

y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")


x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)


s_train <- read.table("train/subject_train.txt")
s_test <- read.table("test/subject_test.txt")

subject <- rbind(s_train, s_test)


#get mean and std measurements

feat <- read.table("features.txt")
useFeat <- grep("-mean\\(\\)|-std\\(\\)", feat$V2)
x <- x[, useFeat]

names(X) <- feat[useFeat, 2]
names(X) <- gsub("\\(|\\)", "", names(X))

#activity names

act <- read.table("activity_labels.txt")
act[, 2]<- tolower(act[,2])
y[, 1] = act[y[ , 1], 2]
names(y) <- "activity"
names(subject)<-"subject"

#merge data set

writ <- cbind(subject, y, x)
write.table(writ, "merged.txt")

#create second data set for averages

numSubj<- length(unique(subject)[,1])
numAct <- length(activity[,1])
numCols <- dim(writ)[2]

file<-writ[1:(numSubj*numAct),]

row<-1

for (s in 1:numSubj)
{
  for (a in 1:numAct)
  {
    file[row,1] <- unique(subject)[,1]
    file [row,2] <- act[a,2]
    temp<- writ[writ$subject == s & writ$activity == act[a,2],]
    file[row, 3:numColumns] <- colMeans(temp[, 3:numColumns])
    row <- row + 1
    
    } 
}

write.table(file,"averages.txt")





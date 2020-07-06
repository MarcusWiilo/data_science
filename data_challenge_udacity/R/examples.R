statesInfo <- read.csv('stateData.csv')

stateSubset <- subset(statesInfo, state.region == 1)
head(stateSubset, 2)
dim(stateSubset)

stateSubsetBracket <- statesInfo[statesInfo$state.region == 1, ]
head(stateSubsetBracket, 2)
dim(stateSubsetBracket)

## reddit examples

reddit <- read.csv('reddit.csv')

table(reddit$employment.status)
summary(reddit)

str(reddit)

levels(reddit$age.range)

# settings levels of ordered factors solution
reddit$age.range <- ordered(reddit$age.range, levels = c('Under 18', '18-24', 
                                                         '25-34', '35-34', '45-54', 
                                                         '22-64', '65 of Above'))

qplot(data = reddit, x = age.range)

# aktenate solution
reddit$age.range <- factor(reddit$age.range, levels = c('Under 18', '18-24', 
                                                        '25-34', '35-34', '45-54', 
                                                        '22-64', '65 of Above'), 
                           ordered = T)

qplot(data = reddit, x = income.range)
#Hello Bryce

I've decided to build you a simple machine learning model using Logistic Regression. I know you said don't worry about building a model, but I'm someone who likes to go above and beyond :) Don't worry, this didn't take me too much time. I'm not too familiar with GitHub, however I'm learning. 

Business problem: I've created a model to predict which of the 1M users have a higher probability of trying out our new PodNN app. My model was 74% accurate in predicting which users that will listen to a podcast. We can go to the marketing team and see how we can target these users. 

Choice of model: 
  1) Since the data came with some labeled data, a supervised machine learning algorithm will work beautifully.
  2) Secondly, I had to decide which type of ML task to chooose: regression or classfication problem. This is naturally a classification problem as the target variables are binary and not a continious variable. 

Here are some of the steps I took and notes.

  1) Loading the packages I needed
  2) Exploratory data analysis
  3) Light preprocessing - quick preprocessing of several columns. Gender column had issues. There were null values which I immputed. State column
  4) Model building - standardizing columns, creating a pipeline
  5) Model evaulation - 74% recall. 95% accuracy. 91% precision and 81% F1. I also used 5 fold cross validation to ensure my model results will generalize to unseen data. Also looked at other classfication metrics such as ROC, and AUC.

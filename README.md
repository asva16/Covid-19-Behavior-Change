# Covid-19-Behavior-Change
Analysis of Covid-19 Behavior Change in Surabaya Raya (Surabaya, Sidoarjo, Gresik, Mojokerto)
This analysis was performed using a sample data, the full analysis was already published somewhere else.

The data used in the analysis of the relationship between variables comes from an offline survey, namely:
![image](https://user-images.githubusercontent.com/48485276/198920314-58dde7df-3669-4966-b9df-3b280a26dfdf.png)

These variables would be used as the predictors while compliance level would be used as the respond.

This is how the data looks like:
![image](https://user-images.githubusercontent.com/48485276/198921639-4d355461-08da-43a7-b179-5d2c9ac06d7f.png)

## Analysis
### Chi-Square Independent Test
The first analysis used chi-square test to determine the relationship between the predictors and the respond variable.
![image](https://user-images.githubusercontent.com/48485276/198920574-227f9f6e-e454-467c-9b10-8fccf7de70af.png)

Variables that have a significant effect on the level of compliance of the people of East Java with α = 10%, are the level of education, knowledge of the 3M program, the perception of the effectiveness of the 3M program, the use of masks, washing hands, carrying hand sanitizer, and keeping a distance.

### Correspondence Analysis
The next analysis used Correspondence Analysis (CA) to show the relationship between two variables. If the categories of 2 variables form an almost overlapping line when drawn from the central point, then there is a relationship between the two categories.
##### Education
![image](https://user-images.githubusercontent.com/48485276/198920798-1553a715-4aa6-453c-8c01-3a91e2d9893b.png)

Undergraduate graduates have the highest tendency to regard 3M's health protocols as still important. People who did not graduate from elementary school have a tendency to not regard the 3M health protocol as something that should be obeyed.
##### Effectiveness Level
![image](https://user-images.githubusercontent.com/48485276/198920836-ddd62afa-8bb3-41d9-b643-4471c276b089.png)

People who claim that the 3M program is effective in warding off the virus tend to think of the 3M program as something that is still important to carry out.
##### Wearing Mask
![image](https://user-images.githubusercontent.com/48485276/198920859-d2b53ed6-716b-4cbe-9621-681f87168f3e.png)

People who always wear masks tend to think of health protocols as something that is still important to carry out.
##### Wash Hands
![image](https://user-images.githubusercontent.com/48485276/198920903-eaac1e1f-8342-4124-bd32-4c982f3c74a1.png)

People who wash their hands often tend to have the perception that the 3M program is still important to run.
##### Carry Hand Sanitizers
![image](https://user-images.githubusercontent.com/48485276/198920935-60de1429-72cb-4e06-890e-ee49d23bb8c3.png)

People who always carry hand sanitizers have a tendency to regard the 3M program as something that is still important to implement.
##### Keep Their Distance
![image](https://user-images.githubusercontent.com/48485276/198920976-40eb39f5-57dc-4b53-a6d2-cd7532eb31ab.png)

People who always keep their distance tend to think of 3M as something that is still important to be implemented.


### Multinomial Regression Analysis
The last analysis implements multinomial regression to test the effect of the predictor variable on the response variable. The regression results give the results in the form of 5 variables that are significant to the level of compliance, namely knowledge of the 3M program, perception of the level of effectiveness of 3M, frequency of using masks, frequency of carrying hand sanitizer, and frequency of maintaining distance. People who know the 3M protocol have a tendency to be more obedient than people who do not know the 3M protocol. The level of community compliance is directly proportional to the frequency of using masks. The tendency of people who always use masks > people who sometimes use masks > people who very rarely use masks > people who never use masks. Similarly, keeping a distance, the level of compliance is also directly proportional to keeping a distance. The tendency to obey people who always keep their distance > people who sometimes keep their distance > people who never keep their distance.

![image](https://user-images.githubusercontent.com/48485276/198921032-64e72894-8b5e-4a6a-b036-7371f304b6b9.png)

## Conclusion and Suggestions
### Conclusion
1.	People who have implemented the 3M protocol and have confidence in the effectiveness of 3M tend to believe that the 3M protocol is important to continue to be implemented.
2.	The highest level of compliance with the application of health protocols is found in the application of the protocol wearing masks.

### Suggestion
The strategy to increase knowledge about Covid-19 and the dangers of Covid-19 must be adjusted to the targets, such as for groups of people who do not know 3M, which are dominated by respondents who did not graduate from elementary school.

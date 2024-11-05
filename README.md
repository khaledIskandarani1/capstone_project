# capstone_project
Data Analyst Capstone Projects
# Data Analytics Projects

This repository contains three data analytics projects . The projects are:

1. **Restaurant Recommendation System**
2. **Loan Defaulter Prediction**
3. **Heart Attack Prediction**

Each project applies different techniques and tools to address real-world problems, and the solutions are implemented using various programming languages, including **Python**, **R**, and **Tableau**.

---

## Project 1: Restaurant Recommendation System

### Overview
This project focuses on building a **restaurant recommendation system** that suggests the best restaurants based on various factors like ratings, cuisine type, and location. The goal is to help a restaurant consolidator revamp its B-to-C portal using intelligent automation technologies.

### Tools and Libraries Used:
- **R**: For data manipulation and visualization.
  - **dplyr**: Data manipulation.
  - **ggplot2**: Data visualization.
  - **readxl**: For reading Excel files.
- **Python**: For processing and building the recommendation engine.
  - **Pandas**, **Scikit-learn**, **Matplotlib**, **Seaborn**

### Approach
- **Data Analysis**: Explored the dataset of restaurants to understand customer preferences, ratings, and other factors that influence restaurant recommendations.
- **Recommendation System**: Built a content-based filtering recommendation engine using Python's **Scikit-learn**.
- **Data Visualization**: Used **ggplot2** in R for data exploration and visualization of trends in restaurant ratings and customer behaviors.

---

## Project 2: Loan Defaulter Prediction

### Overview
This project aims to predict whether a customer will default on a loan based on factors such as credit score, loan amount, employment status, and more. The goal is to help financial institutions reduce risk by predicting loan defaults.

### Tools and Libraries Used:
- **Python**: For data preprocessing, machine learning, and model evaluation.
  - **Pandas**: Data manipulation.
  - **Matplotlib & Seaborn**: Data visualization.
  - **Scikit-learn**: Logistic regression, data preprocessing, and model evaluation.
- **Tableau**: For interactive data visualization and building a dashboard to explore trends and factors contributing to loan defaults.

### Approach
1. **Exploratory Data Analysis (EDA)**: Analyzed the dataset to uncover relationships between features and loan default risk.
2. **Data Preprocessing**: Cleaned the data by handling missing values, scaling numerical features, and splitting the data for training and testing.
3. **Modeling**: Built a **logistic regression model** using **Scikit-learn** to predict loan defaults and evaluated the model with a **confusion matrix** and **classification report**.
4. **Visualization**: Created an interactive **Tableau** dashboard to visualize key insights from the data and model predictions.

**Key Python Libraries Used:**
```python
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix, classification_report
from sklearn.preprocessing import StandardScaler
import warnings
import os
```
## Project 3: Heart Attack Prediction

### Overview
This project focuses on predicting the likelihood of a heart attack based on various health metrics like cholesterol levels, blood pressure, age, and exercise habits. The goal is to help healthcare professionals identify patients at risk and take preventive actions.

### Tools and Libraries Used:
- **Python**: For data preprocessing, machine learning, and model evaluation.
  - **Pandas**: Data manipulation.
  - **Matplotlib & Seaborn**: Data visualization.
  - **Scikit-learn**: Logistic regression, data preprocessing, and model evaluation.
- **Tableau**: For interactive data visualization and building a dashboard to explore trends and factors contributing to loan defaults.

### Approach
1. **Exploratory Data Analysis (EDA)**:  Analyzed the dataset of patient information to identify key factors contributing to heart attacks, such as age, cholesterol levels, blood pressure, and exercise habits.
2. **Data Preprocessing**: Handled missing data, encoded categorical variables, and performed feature scaling.
3. **Modeling**: Built a logistic regression model to predict the likelihood of a heart attack and evaluated the model's performance using a confusion matrix and classification report.
4. **Visualization**: Created a Tableau dashboard to explore the relationships between factors contributing to heart attack risk and visualize predictions.

**Key Python Libraries Used:**
```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix, classification_report
from sklearn.preprocessing import StandardScaler
import warnings
import os


# NLP project (ongoing)
This project aims at implementing n-grams NLP model to generate an OPEC speeches of a given lenght. 
<br />
<br />
It is still under contruction (e.g. classes are not fully definied yet). 
<br />
<br />
An interesting theoretical explanation of such a model can be find here: https://web.stanford.edu/~jurafsky/slp3/3.pdf


# Potential improvements / to do : 
* add stemming (not included for speech-generation purposes)
* improve n-grams model 
* Scrape more speeches + train a model with more data 
* Create an app to viz results 

# Data:
OPEC speeches of 2021 and 2022 from https://www.opec.org/opec_web/en/publications/338.htm
<br /> 
Downloaded at .txt format

# Main code:
Notebook that contains 
* (1) an exploratinon and first cleaning part
* (2) a modelization part (ongoing)

# Classes: 
* TxtAnalysis: gathered all functions necessary to pre-process text data 
* NGrams: contains all functions to implement from scratch an n-grams

# To run the code: 
* have python >= 3.9 installed
* pip install -r requirements.txt

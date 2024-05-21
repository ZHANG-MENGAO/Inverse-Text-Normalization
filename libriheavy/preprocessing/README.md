# preprocess libriheavy
The basic flow of preprocessing are as follows: 
1. Discard instances that contains non-ascii characters and bad ascii characters
    - Exceptions for non-ascii characters: αβρ£°´. We want to keep these because they carry special meanings
    - Bad ascii characters: +=@\| (because the instances containing these symbols are erroneous).
2. Clean the Book text using regular expression with simple heuristics, e.g. replace multiple space with a single space.
3. Clean the Book text and ASR Transcript using alignment (details provided in the next slide)
    - Remove mismatches at the beginning and end of sentences
    - Remove mismatches that either one side is empty
    - Remove mismatches that contains symbols not in the allowable set 
    - Possible drawbacks: may remove useful information.
4. Clean the Book text and ASR Transcript using sequential pattern mining
    - Refer slides 141 - 146. 

P.s. Despite the above procedures there may still be hidden noises in the dataset. The libriheavy may not be a good dataset for ITN task.

# directory structure
main.py is the main point of entrance for the programme

constants.py contains all the constant values for the code

utility.py contains all the utility functions

explore/ contains notebook that explores the property of the dataset. 

# Runing the code
First create a virtural environment and install necessary libraries. 
```
conda create -n prepro python
conda activate prepro
pip install -r requirements.txt
```
Then download the data following the instructions in the outer folder. Finally execute the main.py
```
python main.py
```
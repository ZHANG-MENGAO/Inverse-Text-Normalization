# Introduction
This folder presents the code to run pretrained ThutmoseTagger model and the evaluation methods proposed by ThutmoseTagger. 

# Directory structure

- conf/ 
    configuration for ThutmoseTagger

- eval_data/
    evaluation data 

- NeMo/
    adopted from [NeMo](https://github.com/NVIDIA/NeMo). Did some modifications on the evaluation scripts. 

- test_result/
    the test result of ThutmoseTagger and denormalization model on basic GTN testset and hard testset

- flask_app.py
    code to run the flask app
# Runing code
First create and activate the environment by 
```
conda env create -f environment.yml
conda activate tagger
```
Then run the following to do the inference
```
python flask_app.py
```

To run the evaluation, first compile giza
```
cd giza-pp
make
cd ..
```
Then change the paths in *NeMo/examples/nlp/text_normalization/prepare_dataset_en.sh*
Next execute the following to prepare for the evaluation dataset.
```
bash NeMo/examples/nlp/text_normalization/prepare_dataset_en.sh
```

Finally run the following to do evaluation. Also need to change the paths in this file.
```
bash NeMo/examples/nlp/text_normalization/run_infer.sh
```
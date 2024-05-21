# Project documentation
This folder contains the relevant codes and data for the ITN task. Please check slide number 204-212 of [slides](https://docs.google.com/presentation/d/1ns6aDPO9f82h1LlJPVlxDjX9_kTFBfGKOBSUt49nhoI/edit?usp=sharing) for the things I did in general. If there's any doubts about the contents, please email to ZH0024AO@e.ntu.edu.sg

## Directory Structure
- denormalizer/
    The code to train and evaluate denormalizer model
    [[papaer](https://www.isca-archive.org/interspeech_2021/suter21_interspeech.pdf)] [[code](https://github.com/spitch-oss/denormalizer)]

- docker_files/
    The code to build docker image of a simple flask app that encapsulats ITN models for easy inference.

- GTN/
    the Google Text Normalization dataset. Download from [link](https://www.kaggle.com/datasets/richardwilliamsproat/text-normalization-for-english-russian-and-polish). Should contain 100 files with the names output-000{00to99}-of-00100. Put 00 to 89 into train/, 90 to 94 to val/ and 95 to 99 into test/. Also contains the sampled ITN instances from GTN, and data from AISG.

- libriheavy/
    Same as [libriheavy](https://github.com/k2-fsa/libriheavy) dataset except that preprocessing methods are explored. 

- SPGISpeech/
    The [SPGISpeech](https://arxiv.org/pdf/2104.02014) dataset and preprocessing scripts

- thutmoseTagger/
    The code to run thutmoseTagger and evaluation methods of thutmoseTagger. [[paper](https://arxiv.org/pdf/2208.00064)] [[code](https://github.com/NVIDIA/NeMo)]

For detailed contents and instructions, please refer to the README file in each folder.
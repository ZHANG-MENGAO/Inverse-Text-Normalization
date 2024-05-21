#!/bin/sh
#SBATCH -p PA40q
#SBATCH -w node06
#SBATCH -n 1
#SBATCH -o NeMo-%j-init.output

python examples/nlp/text_normalization_as_tagging/normalization_as_tagging_infer.py\
    pretrained_model=itn_en_thutmose_bert \
    inference.from_file=./default_test.txt \
    inference.out_file=./output.tsv
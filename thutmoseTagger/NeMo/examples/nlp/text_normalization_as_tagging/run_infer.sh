#!/bin/bash

## This bash-script demonstrates how to run inference and evaluation for the Thutmose Tagger model (tagger-based ITN model)

## In order to use it, you need:
## 1. install NeMo
##     git clone https://github.com/NVIDIA/NeMo
## 2. Specify the following paths

## path to NeMo repository, e.g. /home/user/nemo
NEMO_PATH="/home/mazhang/inverse-text-normailzation/NeMo"

## name or local path to pretrained model, e.g. ./nemo_experiments/training.nemo
PRETRAINED_MODEL="itn_en_thutmose_bert"

## path to input and reference files 
# (see the last steps in examples/nlp/text_normalization_as_tagging/prepare_dataset_en.sh,
#   starting from "python ${NEMO_PATH}/examples/nlp/text_normalization_as_tagging/evaluation/get_multi_reference_vocab.py"
#)
# INPUT_FILE="/home/mazhang/inverse-text-normailzation/data_and_result/Tagger_test1000/final_test.output"
INPUT_FILE="/home/mazhang/inverse-text-normailzation/data_and_result/Tagger_test/final_test.output"
# INPUT_FILE="/home/mazhang/txtDenormalization/denormalizer/denor_output.txt"
# INPUT_FILE="/home/mazhang/txtDenormalization/denormalizer/denor_output_1000.txt"
REFERENCE_FILE="/home/mazhang/inverse-text-normailzation/data_and_result/GTN_test/test.labeled"
# REFERENCE_FILE="/home/mazhang/inverse-text-normailzation/data_and_result/GTN_test/test1000.labeled"



export TOKENIZERS_PARALLELISM=false

### run inference on default Google Dataset test
python ${NEMO_PATH}/examples/nlp/text_normalization_as_tagging/normalization_as_tagging_infer.py \
  pretrained_model=${PRETRAINED_MODEL} \
  inference.from_file=${INPUT_FILE} \
  inference.out_file=./final_test.output \
  model.max_sequence_len=1024 \
  inference.batch_size=16

### compare inference results to the reference
python ${NEMO_PATH}/examples/nlp/text_normalization_as_tagging/evaluation/eval.py \
  --reference_file=${REFERENCE_FILE} \
  --inference_file=${INPUT_FILE} \
  --print_other_errors \
  > GTN_tagger_default.report
  # > GTN_tagger_1000.report

  # --inference_file=final_test.output \

### compare inference results to the reference, get separate report per semiotic class
python ${NEMO_PATH}/examples/nlp/text_normalization_as_tagging/evaluation/eval_per_class.py \
  --reference_file=${REFERENCE_FILE} \
  --inference_file=${INPUT_FILE} \
  --output_file=per_class.report
  # --inference_file=final_test.output \
# EVAL_DATA_FOLDER=/home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data

# GTN_TEST_REF=${EVAL_DATA_FOLDER}/GTN/test_written.txt
# GTN_TEST_SRC=${EVAL_DATA_FOLDER}/GTN/test_spoken.txt

# SPGI_TEST_REF=${EVAL_DATA_FOLDER}/SPGI/val_ref.prep.txt
# SPGI_TEST_SRC=${EVAL_DATA_FOLDER}/SPGI/val_input.prep.txt

# ASR_TEST_REF=${EVAL_DATA_FOLDER}/asr_test/asr_eval_target.txt
# ASR_TEST_SRC=${EVAL_DATA_FOLDER}/asr_test/asr_eval_input.txt

# GTNaisg_TEST_REF=${EVAL_DATA_FOLDER}/GTN_aisg/test_written.txt
# GTNaisg_TEST_SRC=${EVAL_DATA_FOLDER}/GTN_aisg/test_spoken.txt

# # Create lists for REF and SRC variables
# REF_LIST=("$GTN_TEST_REF" "$SPGI_TEST_REF" "$ASR_TEST_REF" "$GTNaisg_TEST_REF")
# SRC_LIST=("$GTN_TEST_SRC" "$SPGI_TEST_SRC" "$ASR_TEST_SRC" "$GTNaisg_TEST_SRC")

# CHECKPOINT_PATH=/home/mazhang/pt/txtDenormalization/denormalizer/checkpoints

# for i in "${!REF_LIST[@]}"; do
#     REF="${REF_LIST[$i]}"
#     SRC="${SRC_LIST[$i]}"
#     echo "Processing pair $i: REF=$REF, SRC=$SRC"
#     # Add your processing logic here
#     # For example, zip command: zip -r "output_$i.zip" "$REF" "$SRC"
# done

# # evaluate MS on GTN
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN/test_written.txt  \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN/test_spoken.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/SPGI_TN/GTN_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/SPGI_TN/GTN_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/SPGI_TN/GTN_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/SPGI_TN \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/SPGI_TN \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/SPGI_TN/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MS on SPGI
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/SPGI/val_ref.prep.txt \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/SPGI/val_input.prep.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/SPGI_TN/SPGI_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/SPGI_TN/SPGI_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/SPGI_TN/SPGI_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/SPGI_TN \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/SPGI_TN \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/SPGI_TN/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MS on asr
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/asr_test/asr_eval_target.txt \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/asr_test/asr_eval_input.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/SPGI_TN/asr_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/SPGI_TN/asr_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/SPGI_TN/asr_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/SPGI_TN \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/SPGI_TN \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/SPGI_TN/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MG on GTN
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN/test_written.txt  \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN/test_spoken.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_train/GTN_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_train/GTN_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_train/GTN_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/GTN_train \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTN_train \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTN_train/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MG on GTN'
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN_aisg/test_written.txt  \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN_aisg/test_spoken.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_0to89_last/GTNaisg_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_0to89_last/GTNaisg_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_0to89_last/GTNaisg_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/GTN_train \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTN_train \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTN_train/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MG on SPGI
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/SPGI/val_ref.prep.txt \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/SPGI/val_input.prep.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_0to89_last/SPGI_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_0to89_last/SPGI_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_0to89_last/SPGI_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/GTN_train \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTN_train \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTN_train/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MG on asr
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/asr_test/asr_eval_target.txt \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/asr_test/asr_eval_input.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_0to89_last/asr_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_0to89_last/asr_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_0to89_last/asr_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/GTN_train \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTN_train \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTN_train/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MGS on GTN
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN/test_written.txt  \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN/test_spoken.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN/GTN_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN/GTN_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN/GTN_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/ft_SPGI_TN \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/ft_SPGI_TN \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/ft_SPGI_TN/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MGS on GTN'
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN_aisg/test_written.txt  \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN_aisg/test_spoken.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN/GTNaisg_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN/GTNaisg_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN/GTNaisg_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/ft_SPGI_TN \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/ft_SPGI_TN \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/ft_SPGI_TN/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MGS on SPGI
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/SPGI/val_ref.prep.txt \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/SPGI/val_input.prep.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN/SPGI_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN/SPGI_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN/SPGI_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/ft_SPGI_TN \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/ft_SPGI_TN \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/ft_SPGI_TN/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MGS on asr
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/asr_test/asr_eval_target.txt \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/asr_test/asr_eval_input.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN/asr_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN/asr_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN/asr_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/ft_SPGI_TN \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/ft_SPGI_TN \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/ft_SPGI_TN/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MGS' on GTN
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN/test_written.txt  \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN/test_spoken.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN_prime/GTN_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN_prime/GTN_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN_prime/GTN_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/ft_SPGI_TN_prime \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/ft_SPGI_TN \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/ft_SPGI_TN/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MGS' on GTN'
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN_aisg/test_written.txt  \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN_aisg/test_spoken.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN_prime/GTNaisg_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN_prime/GTNaisg_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN_prime/GTNaisg_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/ft_SPGI_TN_prime \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/ft_SPGI_TN \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/ft_SPGI_TN/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MGS' on SPGI
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/SPGI/val_ref.prep.txt \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/SPGI/val_input.prep.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN_prime/SPGI_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN_prime/SPGI_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN_prime/SPGI_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/ft_SPGI_TN_prime \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/ft_SPGI_TN \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/ft_SPGI_TN/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MGS' on asr
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/asr_test/asr_eval_target.txt \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/asr_test/asr_eval_input.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN_prime/asr_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN_prime/asr_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/ft_SPGI_TN_prime/asr_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/ft_SPGI_TN_prime \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/ft_SPGI_TN \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/ft_SPGI_TN/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate Mcombine on GTN
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN/test_written.txt  \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN/test_spoken.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_SPGI/GTN_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_SPGI/GTN_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_SPGI/GTN_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/GTN_SPGI \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTN_SPGI \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTN_SPGI/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate Mcombine on GTN'
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN_aisg/test_written.txt  \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN_aisg/test_spoken.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_SPGI/GTNaisg_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_SPGI/GTNaisg_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_SPGI/GTNaisg_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/GTN_SPGI \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTN_SPGI \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTN_SPGI/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate Mcombine on SPGI
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/SPGI/val_ref.prep.txt \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/SPGI/val_input.prep.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_SPGI/SPGI_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_SPGI/SPGI_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_SPGI/SPGI_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/GTN_SPGI \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTN_SPGI \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTN_SPGI/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate Mcombine on asr
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/asr_test/asr_eval_target.txt \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/asr_test/asr_eval_input.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_SPGI/asr_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_SPGI/asr_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTN_SPGI/asr_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/GTN_SPGI \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTN_SPGI \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTN_SPGI/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MAS on GTN
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN/test_written.txt  \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN/test_spoken.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTNaisg_SPGI/GTN_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTNaisg_SPGI/GTN_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTNaisg_SPGI/GTN_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/GTNaisg_SPGI \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTNaisg_SPGI \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTNaisg_SPGI/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MAS on GTN'
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN_aisg/test_written.txt  \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/GTN_aisg/test_spoken.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTNaisg_SPGI/GTNaisg_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTNaisg_SPGI/GTNaisg_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTNaisg_SPGI/GTNaisg_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/GTNaisg_SPGI \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTNaisg_SPGI \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTNaisg_SPGI/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MAS on SPGI
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/SPGI/val_ref.prep.txt \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/SPGI/val_input.prep.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTNaisg_SPGI/SPGI_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTNaisg_SPGI/SPGI_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTNaisg_SPGI/SPGI_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/GTNaisg_SPGI \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTNaisg_SPGI \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTNaisg_SPGI/bpe_code \
#     --use-gpu \
#     --force-overwrite

# # evaluate MAS on asr
# python eval.py \
#     --reference /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/asr_test/asr_eval_target.txt \
#     -s /home/mazhang/pt/txtDenormalization/denormalizer/eval/eval_data/asr_test/asr_eval_input.txt \
#     -y /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTNaisg_SPGI/asr_hypothesis.txt \
#     -l en \
#     -o /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTNaisg_SPGI/asr_report.txt \
#     --print-errors \
#     --outfile-errors /home/mazhang/pt/txtDenormalization/denormalizer/model_outputs/GTNaisg_SPGI/asr_report.txt\
#     --checkpoint-dir /home/mazhang/pt/txtDenormalization/denormalizer/checkpoints/GTNaisg_SPGI \
#     --checkpoint-file checkpoint_last.pt \
#     --data-name-or-path /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTNaisg_SPGI \
#     --bpe-codes /home/mazhang/pt/txtDenormalization/denormalizer/data-bin/GTNaisg_SPGI/bpe_code \
#     --use-gpu \
#     --force-overwrite
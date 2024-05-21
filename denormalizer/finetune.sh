#!/bin/bash

outdir=ft_SPGI_TN_test
src=GTN_source
tgt=GTN_target
arch=transformer_normalizer
train=train
val=valid
test=test

# # Split the parallel corpora into train, valid and test blocks
# python3 scripts/split_tr_val_te.py ${outdir}/train_input.prep.txt \
#         ${outdir}/train_ref.prep.txt ${outdir} raw.${src} raw.${tgt}

Apply the bpe result to segment the source and target texts
for l in ${src} ${tgt}; do
  for set in ${train} ${val} ${test}; do
    f=${outdir}/${set}.raw.${l}
    bpe=${outdir}/${set}.bpe.${l}
    echo "apply bpe to ${f} ..."
    subword-nmt apply-bpe -c bpe_code < ${f} > ${bpe}
  done
done

# Preprocess the inputs in the standard way
fairseq-preprocess \
             --source-lang ${src} \
             --target-lang ${tgt} \
             --trainpref ${outdir}/train.bpe \
             --validpref ${outdir}/valid.bpe \
             --testpref ${outdir}/test.bpe \
             --destdir data-bin/${outdir} \
             --tgtdict data-bin/GTN_train/dict.GTN_target.txt \
             --srcdict data-bin/GTN_train/dict.GTN_source.txt \
             --thresholdtgt 0 \
             --thresholdsrc 0 \
             --workers 25

# Stick the code where it is expected
mv ${outdir}/bpe_code data-bin/${outdir}/bpe_code;

python scripts/custom_arch.py data-bin/ft_SPGI_TN \
        --source-lang ${src} \
        --target-lang ${tgt} \
        --arch ${arch} \
        --share-all-embeddings \
        --dropout 0.3 \
        --weight-decay 8.4e-3 \
        --criterion label_smoothed_cross_entropy \
        --label-smoothing 0.1 \
        --optimizer adam \
        --adam-betas '(0.9, 0.98)' \
        --clip-norm 0.0 \
        --lr 1e-3 \
        --lr-scheduler inverse_sqrt \
        --warmup-updates 100 \
        --max-tokens 3584 \
        --update-freq 16 \
        --max-update 10000 \
        --max-epoch 13 \
        --save-dir checkpoints/${outdir} \
        --skip-invalid-size-inputs-valid-test \
        --ddp-backend=no_c10d \
        --restore-file checkpoints/GTN_train/checkpoint_last.pt \
        --reset-optimizer --reset-lr-scheduler --reset-dataloader
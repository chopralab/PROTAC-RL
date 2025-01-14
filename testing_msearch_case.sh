#!/usr/bin/env bash
# this file used for generating SMILES with model having been trained with reinforcement learning using multinomial sampling for case

dataset_name=PROTAC
random=random

agent_step=2000
ZINC_step=300000
PROTAC_step=6000

beamsize=32
test_nbest=250

train_type=M
# beam search or multinomial sampling
score_function=PK
case=elovl1

model=Model_Agent_on_${dataset_name}_zinc${ZINC_step}_protac${PROTAC_step}_${random}_${NL}${train_type}_${score_function}

chooseGpu=1

echo "multinomial search using agent model"
CUDA_VISIBLE_DEVICES=0 python translate_ms.py -model checkpoints/${dataset_name}/Agent/${case}/${model}_step_${agent_step}.pt \
                    -src case/${case}/src-test.txt \
                    -tgt case/${case}/tgt-test.txt \
                    -output case/${case}/predictions_ms_${agent_step}_${test_nbest}.txt \
                    -batch_size 1 -replace_unk -max_length 200 -beam_size $beamsize -verbose -n_best $test_nbest \
                    -gpu 0 -log_probs -log_file ''




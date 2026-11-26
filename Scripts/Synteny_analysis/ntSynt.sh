#!/bin/bash

# Load conda environement
conda activate ntsynt

# Move to working directory
cd /solea_solea_analysis/synteny/;

# Assign variables
sol_sene=../GCF_019176455.1_IFAPA_SoseM_1_genomic.fna
sol_sol=../GCF_958295425.1_fSolSol10.1_genomic.fna
mic_vari=../GCA_963457635.1_fMicVar1.1_genomic.fna
ssol_fai=../GCF_958295425.1_fSolSol10.1_genomic.fna.fai
ssen_fai=../GCF_019176455.1_IFAPA_SoseM_1_genomic.fna.fai
mvar_fai=../GCA_963457635.1_fMicVar1.1_genomic.fna.fai

# Run synteny analysis with ntSynt
ntSynt $sol_sene $sol_sol $mic_vari -p ntsynt_flatfish_chrom -t 36 -d 30

# Get statistics on the result
python ntSynt/analysis_scripts/denovo_synteny_block_stats.py --tsv ntsynt_flatfish_chrom.synteny_blocks.tsv --fai $ssol_fai $ssen_fai $mvar_fai

# Prepare the files for visualization
python ntSynt/visualization_scripts/sort_ntsynt_blocks.py --synteny_blocks ntsynt_flatfish_chrom.synteny_blocks.tsv --sort_order $ssol_fai $ssen_fai $mvar_fai --fais > ntsynt_flatfish_chrom.synteny_blocks.sorted.tsv
python ntSynt/visualization_scripts/format_blocks_gggenomes.py --fai $ssol_fai $ssen_fai $mvar_fai --prefix ntsynt_flatfish_chrom --blocks ntsynt_flatfish_chrom.synteny_blocks.sorted.tsv --length 100 --colour $mic_vari
cat ntsynt_flatfish_chrom.links.tsv | mlr --tsv sort -f strand -n block_id > ntsynt_flatfish_chrom.links.sorted.tsv && mv ntsynt_flatfish_chrom.links.sorted.tsv ntsynt_flatfish_chrom.links.tsv
cat ntsynt_flatfish_chrom.sequence_lengths.tsv | mlr --tsv sort -f seq_id > ntsynt_flatfish_chrom.sequence_lengths.sorted.tsv && mv ntsynt_flatfish_chrom.sequence_lengths.sorted.tsv ntsynt_flatfish_chrom.sequence_lengths.tsv

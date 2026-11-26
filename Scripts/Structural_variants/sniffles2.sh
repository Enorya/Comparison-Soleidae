#!/bin/bash

# Load conda environment
conda activate sv-detection

# Move to working directory
cd /solea_solea_analysis/sv-detection/sniffles2/;

# Assign variables
ref_genome=../../chrom_solea_senegalensis.fasta
bam=../hifi_vs_solsen.sort.bam
out=./sniffles2_SV_calling.vcf

# Launch script
sniffles -i $bam --reference $ref_genome -v $out -t 36
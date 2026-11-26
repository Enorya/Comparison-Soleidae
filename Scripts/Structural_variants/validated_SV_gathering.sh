#!/bin/bash

# Load conda environment
conda activate sv-detection

# Extract the original IDs of the 114,993 validated SVs
bcftools view -i 'INFO/SUPP="2"' merged_validation.vcf | \
    grep -v "^#" | \
    awk '{split($11, a, ":"); print a[8]}' | \
    tr ',' '\n' | sort -u > validated_SV_IDs.txt

# Filter the original merged read-based SV calling
bcftools view -i 'ID=@validated_SV_IDs.txt' comparison-SURVIVOR/merged_filtered_SV.vcf -O v -o validated_read-based_SV.vcf


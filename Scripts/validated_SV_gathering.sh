# Load conda environment
conda activate sv-detection

# Extract the original IDs of the 114,993 validated SVs
bcftools view -i 'INFO/SUPP="2"' merged_validation.vcf | \
    grep -v "^#" | \
    awk '{split($11, a, ":"); print a[8]}' | \
    tr ',' '\n' | sort -u > validated_read_sv_ids.txt

# Filter the original merged read-based SV calling
bcftools view -i 'ID=@validated_read_sv_ids.txt' comparison-SURVIVOR-solsen/comparison_1kbp_min2_50bp_strand-type1.vcf -O v -o validated_read-based_SV.vcf


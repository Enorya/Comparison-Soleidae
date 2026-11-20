# Load conda environment
conda activate sv-detection

# Move to working directory
cd /path/to/working/directory/solea_solea_analysis/sv-detection/;

# Assign variables
REF=../chrom_solea_senegalensis.fasta
QUERY_ASM=../chrom_solea_solea.fasta
READ_SV_VCF=../comparison-SURVIVOR-solsen/comparison_1kbp_min2_50bp_strand-type1.vcf

# 1. Align S. senegalensis to S. solea reference
minimap2 -a -x asm5 --cs -r2k -t 32 $REF $QUERY_ASM | samtools sort -@ 32 -m 4G -o solsen_vs_solsol.sorted.bam
samtools index solsen_vs_solsol.sorted.bam

# 2. Call SVs from the assembly alignment
svim-asm haploid ./svim_asm_out solsen_vs_solsol.sorted.bam $REF

# 3. Filter assembly SVs to match your size threshold (e.g., >= 50 bp)
bcftools view -i 'INFO/SVLEN >= 50 || INFO/SVLEN <= -50' ./svim_asm_out/variants.vcf > asm_SVs_50bp.vcf

# 4. Create a file listing the two VCFs to compare
ls $READ_SV_VCF asm_SVs_50bp.vcf > vcf_list.txt

# 5. Merge SVs within 1000 bp of each other, requiring the same SV type (1) and strand (1)
SURVIVOR merge vcf_list.txt 1000 1 1 1 0 50 merged_validation.vcf

# 6. Count how many read-based SVs were confirmed by the assembly (SUPP=2)
grep -v "^#" merged_validation.vcf | grep -c "SUPP=2"

# 7. Count total read-based SVs to calculate your validation percentage
grep -v "^#" $READ_SV_VCF | wc -l
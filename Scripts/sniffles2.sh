# Load conda environment
conda activate sv-detection

# Move to working directory
cd /path/to/working/directory/solea_solea_analysis/sv-detection/sniffles2/;

# Assign variables
ref_genome=../../chrom_solea_senegalensis.fasta
bam=../hifi_vs_solsen_correct.sort.bam
out=./hifi_vs_solsol-correct_sniffles.vcf

# Launch script
sniffles -i $bam --reference $ref_genome -v $out -t 36
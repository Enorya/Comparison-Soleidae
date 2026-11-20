# Load conda environment
conda activate sv-detection

# Move to working directory
cd /path/to/working/directory/solea_solea_analysis/sv-detection/dysgu/;

# Assign variables
ref_genome=../../chrom_solea_senegalensis.fasta
bam=../hifi_vs_solsen_correct.sort.bam
out=./dysgu_long-read_solsen-correct.vcf

# Launch script
dysgu call --mode pacbio --pl pacbio $ref_genome temp/ $bam -o $out -p 36 -c -x
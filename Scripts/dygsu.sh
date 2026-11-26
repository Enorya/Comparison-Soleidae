# Load conda environment
conda activate sv-detection

# Move to working directory
cd /solea_solea_analysis/sv-detection/dysgu/;

# Assign variables
ref_genome=../../chrom_solea_senegalensis.fasta
bam=../hifi_vs_solsen.sort.bam
out=./dysgu_SV_calling.vcf

# Launch script
dysgu call --mode pacbio --pl pacbio $ref_genome temp/ $bam -o $out -p 36 -c -x
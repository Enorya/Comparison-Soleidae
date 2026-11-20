# Load conda environment
conda activate sv-detection

# Move to working directory
cd /path/to/working/directory/solea_solea_analysis/sv-detection/;

# Assign variables
ref_genome=../chrom_solea_senegalensis.fasta
hifi=../ERR11242127.fastq
out=./hifi_vs_solsen_correct.sam
bam=./hifi_vs_solsen_correct.sort.bam

# Align the reads using minimap2
minimap2 -a -x map-hifi --MD $ref_genome $hifi -o $out -t 36

# Sort and compress the sam file
samtools sort -@ 36 -o $bam $out

# Index the bam file
samtools index -@ 36 $bam
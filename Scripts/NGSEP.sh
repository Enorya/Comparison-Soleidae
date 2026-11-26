# Load modules on the cluster
module load Java/17.0.6

# Move to working directory
cd /solea_solea_analysis/sv-detection/ngsep_SV/NGSEPcore/;

# Assign variables
ref_genome=../../../chrom_solea_senegalensis.fasta
bam=../../hifi_vs_solsen.sort.bam
out=ngsep_SV_calling
log=ngsep_SV_calling.log

# Launch script
java -jar NGSEPcore_5.0.0.jar SingleSampleVariantsDetector -i $bam -r $ref_genome -o $out -sampleId hifiNgsep -runLongReadSVs -maxAlnsPerStartPos 2 -minQuality 40 &> $log
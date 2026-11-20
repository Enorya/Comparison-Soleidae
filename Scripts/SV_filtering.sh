# Load conda environment
conda activate sv-detection

# Move to working directory
cd /path/to/working/directory/solea_solea_analysis/sv-detection/comparison-SURVIVOR-solsen-correct-redo/;

# Filter Sniffles2 SVs
grep "^#" ../sniffles2/hifi_vs_solsen_sniffles.vcf > hifi_vs_solsen_sniffles_filtered.vcf
grep -v "^#" ../sniffles2/hifi_vs_solsen_sniffles.vcf | awk -F'[;=]' '{ if ( $9 > 20 ) print $0 }' | awk '{ if ( $7 == "PASS" ) print $0 }' | awk '{ if ( $6 > 54 ) print $0 }' >> hifi_vs_solsen_sniffles_filtered.vcf

# Filter Dygsu SVs
grep "^#" ../dysgu/dysgu_long-read_solsen-correct.vcf > hifi_vs_solsen_dygsu_filtered.vcf
grep -v "^#" ../dysgu/dysgu_long-read_solsen-correct.vcf | awk '{ if ( $7 == "PASS" ) print $0 }' | awk -F'[;=]' '{ if ( $38 > 19 ) print $0 }' | awk -F'[:]' '{ if ( $24 > 54 ) print $0 }' >> hifi_vs_solsen_dygsu_filtered.vcf

# Filter NGSEP SVs
grep "^#" ../ngsep_SV_long-read_vs-sene/NGSEPcore/ngsep_SV_long-read_vs-sene-correct_SVsLongReads.vcf > hifi_vs_solsen_ngsep_filtered.vcf
grep -v "^#" ../ngsep_SV_long-read_vs-sene/NGSEPcore/ngsep_SV_long-read_vs-sene-correct_SVsLongReads.vcf | awk '{ if ( $6 > 54) print $0 }' >> hifi_vs_solsen_ngsep_filtered.vcf

# Generate SURVIVOR summary for each SV caller
SURVIVOR stats hifi_vs_solsen_sniffles_filtered.vcf -1 -1 -1 sniffles2_summary
SURVIVOR stats hifi_vs_solsen_dygsu_filtered.vcf -1 -1 -1 dygsu_summary
SURVIVOR stats hifi_vs_solsen_ngsep_filtered.vcf -1 -1 -1 ngsep_summary

# Create a VCF file containing the filtered SVs
SURVIVOR merge files 1000 2 1 1 0 50 comparison_1kbp_min2_50bp_strand-type1.vcf

# Generate a comparison matrix between the methods
SURVIVOR genComp comparison_1kbp_min2_50bp_strand-type1.vcf 0 comparison_1kbp_min2_50bp_strand-type1.mat

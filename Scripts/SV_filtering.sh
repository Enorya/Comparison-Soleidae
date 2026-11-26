# Load conda environment
conda activate sv-detection

# Move to working directory
cd /solea_solea_analysis/sv-detection/comparison-SURVIVOR/;

# Filter Sniffles2 SVs
grep "^#" ../sniffles2/sniffles2_SV_calling.vcf > sniffles2_filtered_SV.vcf
grep -v "^#" ../sniffles2/sniffles2_SV_calling.vcf | awk -F'[;=]' '{ if ( $9 > 20 ) print $0 }' | awk '{ if ( $7 == "PASS" ) print $0 }' | awk '{ if ( $6 > 54 ) print $0 }' >> sniffles2_filtered_SV.vcf

# Filter Dygsu SVs
grep "^#" ../dysgu/dygsu_SV_calling.vcf > dygsu_filtered_SV.vcf
grep -v "^#" ../dysgu/dygsu_SV_calling.vcf | awk '{ if ( $7 == "PASS" ) print $0 }' | awk -F'[;=]' '{ if ( $38 > 19 ) print $0 }' | awk -F'[:]' '{ if ( $24 > 54 ) print $0 }' >> dygsu_filtered_SV.vcf

# Filter NGSEP SVs
grep "^#" ../ngsep_SV/NGSEPcore/ngsep_SV_calling.vcf > ngsep_filtered_SV.vcf
grep -v "^#" ../ngsep_SV/NGSEPcore/ngsep_SV_calling.vcf | awk '{ if ( $6 > 54) print $0 }' >> ngsep_filtered_SV.vcf

# Generate SURVIVOR summary for each SV caller
SURVIVOR stats sniffles2_filtered_SV.vcf -1 -1 -1 sniffles2_summary
SURVIVOR stats dygsu_filtered_SV.vcf -1 -1 -1 dygsu_summary
SURVIVOR stats ngsep_filtered_SV.vcf -1 -1 -1 ngsep_summary

# Create a VCF file containing the filtered SVs
SURVIVOR merge files 1000 2 1 1 0 50 merged_filtered_SV.vcf

# Generate a comparison matrix between the methods
SURVIVOR genComp merged_filtered_SV.vcf 0 merged_filtered_SV.mat

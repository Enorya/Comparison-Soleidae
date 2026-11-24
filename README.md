# Comparison of Soleidae

This repository contains the scripts and VCF files of the structural variants (SVs) calls between two species of the genus Solea.
This work is part of the following paper (in revision): Geslain et al., Comparison of Soleidae flatfishes reveals synteny, structural variation, a candidate sex-determining gene and recent speciation

- The scripts can be found in the `Scripts` directory and are divided as follows:

    1. [Minimap2](Scripts/minimap2.sh) contains the commands used to map the long Pacbio HiFi reads to the genome of *Solea senegalensis*
    2. [Dygsu](Scripts/dygsu.sh), [NGSEP](Scripts/NGSEP.sh) and [Sniffles2](Scripts/sniffles2.sh) contains the commands used to call the SVs
    3. [SV_filtering](Scripts/SV_filtering.sh) contains the commands used to filter and merge the detected SVs
    4. [Orthogonal_validation](Scripts/orthogonal_validation.sh) contains the commands used to validate by mapping the genome of *S. senegalensis* to the reference genome of *S. solea* and calling SVs between them
    5. [Validated_SV_retrieval](Scripts/validated_SV_gathering.sh) contains the commands used to retrieve only the validated SVs via assembly-to-assembly validation

- The folder `SV_callings` contains the basic SV calling for the following 3 tools: Dygsu, NGSEP and Sniffles2.

- The directory `SV_filtering` contains the filtered SV vcf files for the 3 same datasets.

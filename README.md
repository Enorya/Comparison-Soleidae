# Comparison of Soleidae

This repository contains the scripts used to call the structural variants (SVs) between two species of the genus Solea.
This work is part of the following paper (in revision): Geslain et al., Comparison of Soleidae flatfishes reveals synteny, structural variation, a candidate sex-determining gene and recent speciation

The scripts are divided as follows:

1. [Minimap2](Scripts/minimap2.sh) contains the commands used to map the long Pacbio HiFi reads to the genome of *Solea senegalensis*
2. [Dygsu](Scripts/dygsu.sh), [NGSEP](Scripts/NGSEP.sh) and [Sniffles2](Scripts/sniffles2.sh) contains the commands used to call the SVs
3. [SV_filetering](Scripts/SV_filtering.sh) contains the commands used filter and merge the detected SVs
4. [Orthogonal_validation](Scripts/orthogonal_validation.sh) contains the commands used to validate by mapping the genome of *S. senegalensis* to the reference genome of *S. solea* and calling SVs between them

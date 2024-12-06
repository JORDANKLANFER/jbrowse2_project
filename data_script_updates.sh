#!/bin/bash

# Ensure directories exist
cd "$(dirname "$0")"

#for syntely vie alignments using minimap 
#make super minimap installed 
#add to overall data script upon merging to main 
# Run script in terminal: ./data_script_updates.sh
mkdir -p data/synteny_data

# Align HIV-1 vs. HIV-2
minimap2  data/hiv2_data/hiv2_genome.fna data/hiv1_data/hiv1_genome.fna > data/synteny_data/hiv1_hiv2.paf

# Align HIV-1 vs. SIV
minimap2 data/siv_data/siv_genome.fna data/hiv1_data/hiv1_genome.fna > data/synteny_data/hiv1_siv.paf

# Align HIV-2 vs. SIV
minimap2  data/siv_data/siv_genome.fna data/hiv2_data/hiv2_genome.fna > data/synteny_data/hiv2_siv.paf

jbrowse add-track hiv1_hiv2.paf --assemblyNames peach,grape --load copy --out /var/www/html/jbrowse
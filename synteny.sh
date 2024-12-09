#!/bin/bash
#create pafs 
#need minimap 2

#minimap2 --protein -c target_proteins.fasta query_proteins.fasta > protein_alignment.paf
#ref
#minimap2 grape.fa peach.fa > peach_vs_grape.paf
#jbrowse add-track peach_vs_grape.paf --assemblyNames peach,grape --load inPlace

mkdir -p ./data/synteny


minimap2 data/hiv1_data/hiv2_genome.fna data/hiv1_data/hiv1_genome.fna > data/synteny/hiv1_vs_hiv2.paf
jbrowse add-track hiv1_vs_hiv2.paf --assemblyNames hiv1,hiv2 --load inPlace
#!/bin/bash

# Genome and Annotation Fetching Script

# Ensure required tools (wget, samtools, jbrowse) are installed before running this script.
# Run this script in the jbrowse2 directory:
# chmod +x fetch_and_process_data.sh && ./fetch_and_process_data.sh

# ------------------------------------------------------------------------

# Navigate to script directory
cd "$(dirname "$0")"

# Create main data directory
mkdir -p ./data

# ------------------------------------------------------------------------
# Reference Genome and Annotation URLs
HIV1_reference_genome="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/864/765/GCF_000864765.1_ViralProj15476/GCF_000864765.1_ViralProj15476_genomic.fna.gz"
HIV1_annotations="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/864/765/GCF_000864765.1_ViralProj15476/GCF_000864765.1_ViralProj15476_genomic.gff.gz"

HIV2_reference_genome="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/856/385/GCF_000856385.1_ViralProj14991/GCF_000856385.1_ViralProj14991_genomic.fna.gz"
HIV2_annotations="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/856/385/GCF_000856385.1_ViralProj14991/GCF_000856385.1_ViralProj14991_genomic.gff.gz"

SIV_reference_genome="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/863/925/GCF_000863925.1_ViralProj15501/GCF_000863925.1_ViralProj15501_genomic.fna.gz"
SIV_annotations="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/863/925/GCF_000863925.1_ViralProj15501/GCF_000863925.1_ViralProj15501_genomic.gff.gz"

# ------------------------------------------------------------------------
# Protein Sequence and Annotation URLs
HIV1_M_B_gag_pol="https://rest.uniprot.org/uniprotkb/P12497.fasta"
HIV1_M_C_gag_pol="https://rest.uniprot.org/uniprotkb/O12158.fasta"
HIV2_A_gag_pol="https://rest.uniprot.org/uniprotkb/P12451.fasta"
HIV2_B_gag_pol="https://rest.uniprot.org/uniprotkb/P15833.fasta"
SIV_cpz_gag_pol="https://rest.uniprot.org/uniprotkb/Q1A267.fasta"

HIV1_M_B_env="https://rest.uniprot.org/uniprotkb/P12490.fasta"
HIV1_M_C_env="https://rest.uniprot.org/uniprotkb/O12164.fasta"
HIV2_A_env="https://rest.uniprot.org/uniprotkb/P12449.fasta"
HIV2_B_env="https://rest.uniprot.org/uniprotkb/P15831.fasta"
SIV_cpz_env="https://rest.uniprot.org/uniprotkb/Q1A261.fasta"

HIV1_M_B_gag_pol_a="https://rest.uniprot.org/uniprotkb/P12497.gff?fields=ft_var_seq%2Cft_variant%2Cft_non_cons%2Cft_non_std%2Cft_non_ter%2Cft_conflict%2Cft_unsure%2Cft_act_site%2Cft_binding%2Cft_dna_bind%2Cft_site%2Cft_mutagen%2Cft_intramem%2Cft_topo_dom%2Cft_transmem%2Cft_chain%2Cft_crosslnk%2Cft_disulfid%2Cft_carbohyd%2Cft_init_met%2Cft_lipid%2Cft_mod_res%2Cft_peptide%2Cft_propep%2Cft_signal%2Cft_transit%2Cft_strand%2Cft_helix%2Cft_turn%2Cft_coiled%2Cft_compbias%2Cft_domain%2Cft_motif%2Cft_region%2Cft_repeat%2Cft_zn_fing"  
HIV1_M_C_gag_pol_a="https://rest.uniprot.org/uniprotkb/O12158.gff?fields=ft_var_seq%2Cft_variant%2Cft_non_cons%2Cft_non_std%2Cft_non_ter%2Cft_conflict%2Cft_unsure%2Cft_act_site%2Cft_binding%2Cft_dna_bind%2Cft_site%2Cft_mutagen%2Cft_intramem%2Cft_topo_dom%2Cft_transmem%2Cft_chain%2Cft_crosslnk%2Cft_disulfid%2Cft_carbohyd%2Cft_init_met%2Cft_lipid%2Cft_mod_res%2Cft_peptide%2Cft_propep%2Cft_signal%2Cft_transit%2Cft_strand%2Cft_helix%2Cft_turn%2Cft_coiled%2Cft_compbias%2Cft_domain%2Cft_motif%2Cft_region%2Cft_repeat%2Cft_zn_fing"
HIV2_B_gag_pol_a="https://rest.uniprot.org/uniprotkb/P15833.gff?fields=ft_var_seq%2Cft_variant%2Cft_non_cons%2Cft_non_std%2Cft_non_ter%2Cft_conflict%2Cft_unsure%2Cft_act_site%2Cft_binding%2Cft_dna_bind%2Cft_site%2Cft_mutagen%2Cft_intramem%2Cft_topo_dom%2Cft_transmem%2Cft_chain%2Cft_crosslnk%2Cft_disulfid%2Cft_carbohyd%2Cft_init_met%2Cft_lipid%2Cft_mod_res%2Cft_peptide%2Cft_propep%2Cft_signal%2Cft_transit%2Cft_strand%2Cft_helix%2Cft_turn%2Cft_coiled%2Cft_compbias%2Cft_domain%2Cft_motif%2Cft_region%2Cft_repeat%2Cft_zn_fing"
HIV2_A_gag_pol_a="https://rest.uniprot.org/uniprotkb/P12451.gff?fields=ft_var_seq%2Cft_variant%2Cft_non_cons%2Cft_non_std%2Cft_non_ter%2Cft_conflict%2Cft_unsure%2Cft_act_site%2Cft_binding%2Cft_dna_bind%2Cft_site%2Cft_mutagen%2Cft_intramem%2Cft_topo_dom%2Cft_transmem%2Cft_chain%2Cft_crosslnk%2Cft_disulfid%2Cft_carbohyd%2Cft_init_met%2Cft_lipid%2Cft_mod_res%2Cft_peptide%2Cft_propep%2Cft_signal%2Cft_transit%2Cft_strand%2Cft_helix%2Cft_turn%2Cft_coiled%2Cft_compbias%2Cft_domain%2Cft_motif%2Cft_region%2Cft_repeat%2Cft_zn_fing"
SIV_cpz_gag_pol_a="https://rest.uniprot.org/uniprotkb/Q1A267.gff?fields=ft_var_seq%2Cft_variant%2Cft_non_cons%2Cft_non_std%2Cft_non_ter%2Cft_conflict%2Cft_unsure%2Cft_act_site%2Cft_binding%2Cft_dna_bind%2Cft_site%2Cft_mutagen%2Cft_intramem%2Cft_topo_dom%2Cft_transmem%2Cft_chain%2Cft_crosslnk%2Cft_disulfid%2Cft_carbohyd%2Cft_init_met%2Cft_lipid%2Cft_mod_res%2Cft_peptide%2Cft_propep%2Cft_signal%2Cft_transit%2Cft_strand%2Cft_helix%2Cft_turn%2Cft_coiled%2Cft_compbias%2Cft_domain%2Cft_motif%2Cft_region%2Cft_repeat%2Cft_zn_fing" 
HIV1_M_B_env_a="https://rest.uniprot.org/uniprotkb/P12490.gff?fields=ft_var_seq%2Cft_variant%2Cft_non_cons%2Cft_non_std%2Cft_non_ter%2Cft_conflict%2Cft_unsure%2Cft_act_site%2Cft_binding%2Cft_dna_bind%2Cft_site%2Cft_mutagen%2Cft_intramem%2Cft_topo_dom%2Cft_transmem%2Cft_chain%2Cft_crosslnk%2Cft_disulfid%2Cft_carbohyd%2Cft_init_met%2Cft_lipid%2Cft_mod_res%2Cft_peptide%2Cft_propep%2Cft_signal%2Cft_transit%2Cft_strand%2Cft_helix%2Cft_turn%2Cft_coiled%2Cft_compbias%2Cft_domain%2Cft_motif%2Cft_region%2Cft_repeat%2Cft_zn_fing" 
HIV1_M_C_env_a="https://rest.uniprot.org/uniprotkb/O12164.gff?fields=ft_var_seq%2Cft_variant%2Cft_non_cons%2Cft_non_std%2Cft_non_ter%2Cft_conflict%2Cft_unsure%2Cft_act_site%2Cft_binding%2Cft_dna_bind%2Cft_site%2Cft_mutagen%2Cft_intramem%2Cft_topo_dom%2Cft_transmem%2Cft_chain%2Cft_crosslnk%2Cft_disulfid%2Cft_carbohyd%2Cft_init_met%2Cft_lipid%2Cft_mod_res%2Cft_peptide%2Cft_propep%2Cft_signal%2Cft_transit%2Cft_strand%2Cft_helix%2Cft_turn%2Cft_coiled%2Cft_compbias%2Cft_domain%2Cft_motif%2Cft_region%2Cft_repeat%2Cft_zn_fing" 
HIV2_A_env_a="https://rest.uniprot.org/uniprotkb/P12449.gff?fields=ft_var_seq%2Cft_variant%2Cft_non_cons%2Cft_non_std%2Cft_non_ter%2Cft_conflict%2Cft_unsure%2Cft_act_site%2Cft_binding%2Cft_dna_bind%2Cft_site%2Cft_mutagen%2Cft_intramem%2Cft_topo_dom%2Cft_transmem%2Cft_chain%2Cft_crosslnk%2Cft_disulfid%2Cft_carbohyd%2Cft_init_met%2Cft_lipid%2Cft_mod_res%2Cft_peptide%2Cft_propep%2Cft_signal%2Cft_transit%2Cft_strand%2Cft_helix%2Cft_turn%2Cft_coiled%2Cft_compbias%2Cft_domain%2Cft_motif%2Cft_region%2Cft_repeat%2Cft_zn_fing" 
HIV2_B_env_a="https://rest.uniprot.org/uniprotkb/P15831.gff?fields=ft_var_seq%2Cft_variant%2Cft_non_cons%2Cft_non_std%2Cft_non_ter%2Cft_conflict%2Cft_unsure%2Cft_act_site%2Cft_binding%2Cft_dna_bind%2Cft_site%2Cft_mutagen%2Cft_intramem%2Cft_topo_dom%2Cft_transmem%2Cft_chain%2Cft_crosslnk%2Cft_disulfid%2Cft_carbohyd%2Cft_init_met%2Cft_lipid%2Cft_mod_res%2Cft_peptide%2Cft_propep%2Cft_signal%2Cft_transit%2Cft_strand%2Cft_helix%2Cft_turn%2Cft_coiled%2Cft_compbias%2Cft_domain%2Cft_motif%2Cft_region%2Cft_repeat%2Cft_zn_fing" 
SIV_cpz_env_a="https://rest.uniprot.org/uniprotkb/Q1A261.gff?fields=ft_var_seq%2Cft_variant%2Cft_non_cons%2Cft_non_std%2Cft_non_ter%2Cft_conflict%2Cft_unsure%2Cft_act_site%2Cft_binding%2Cft_dna_bind%2Cft_site%2Cft_mutagen%2Cft_intramem%2Cft_topo_dom%2Cft_transmem%2Cft_chain%2Cft_crosslnk%2Cft_disulfid%2Cft_carbohyd%2Cft_init_met%2Cft_lipid%2Cft_mod_res%2Cft_peptide%2Cft_propep%2Cft_signal%2Cft_transit%2Cft_strand%2Cft_helix%2Cft_turn%2Cft_coiled%2Cft_compbias%2Cft_domain%2Cft_motif%2Cft_region%2Cft_repeat%2Cft_zn_fing" 
# ------------------------------------------------------------------------
# Directory Setup

if [[ -d "./data/hiv1_data" && -d "./data/hiv2_data" && -d "./data/siv_data" && \
      -d "./data/gag_pol" && -d "./data/env" && \
      -d "./data/gag_pol_annotations" && -d "./data/env_annotations" ]]; then
    exit 0
fi

mkdir -p ./data/hiv1_data ./data/hiv2_data ./data/siv_data
mkdir -p ./data/gag_pol ./data/env
mkdir -p ./data/gag_pol_annotations ./data/env_annotations

# ------------------------------------------------------------------------
# Download Reference Genomes and Annotations
echo "Downloading genomes..."
wget -O ./data/hiv1_data/hiv1_genome.fna.gz "$HIV1_reference_genome"
gunzip -f ./data/hiv1_data/hiv1_genome.fna.gz
samtools faidx ./data/hiv1_data/hiv1_genome.fna
wget -O ./data/hiv2_data/hiv2_genome.fna.gz "$HIV2_reference_genome"
gunzip -f ./data/hiv2_data/hiv2_genome.fna.gz
samtools faidx ./data/hiv2_data/hiv2_genome.fna
wget -O ./data/siv_data/siv_genome.fna.gz "$SIV_reference_genome"
gunzip -f ./data/siv_data/siv_genome.fna.gz
samtools faidx ./data/siv_data/siv_genome.fna

echo "Downloading annotations..."
wget -O ./data/hiv1_data/hiv1_annotations.gff.gz "$HIV1_annotations"
wget -O ./data/hiv2_data/hiv2_annotations.gff.gz "$HIV2_annotations"
wget -O ./data/siv_data/siv_annotations.gff.gz "$SIV_annotations"

# ------------------------------------------------------------------------
# Download Protein Sequences and Annotations
echo "Downloading Gag-Pol protein sequences..."
wget -O ./data/gag_pol/HIV1_M_B_gag_pol.fasta "$HIV1_M_B_gag_pol"
wget -O ./data/gag_pol/HIV1_M_C_gag_pol.fasta "$HIV1_M_C_gag_pol"
wget -O ./data/gag_pol/HIV2_A_gag_pol.fasta "$HIV2_A_gag_pol"
wget -O ./data/gag_pol/HIV2_B_gag_pol.fasta "$HIV2_B_gag_pol"
wget -O ./data/gag_pol/SIV_cpz_gag_pol.fasta "$SIV_cpz_gag_pol"

echo "Downloading Env protein sequences..."
wget -O ./data/env/HIV1_M_B_env.fasta "$HIV1_M_B_env"
wget -O ./data/env/HIV1_M_C_env.fasta "$HIV1_M_C_env"
wget -O ./data/env/HIV2_A_env.fasta "$HIV2_A_env"
wget -O ./data/env/HIV2_B_env.fasta "$HIV2_B_env"
wget -O ./data/env/SIV_cpz_env.fasta "$SIV_cpz_env"

echo "Downloading Gag-Pol protein annotations..."
wget -O ./data/gag_pol_annotations/HIV1_M_B_gag_pol.gff "$HIV1_M_B_gag_pol_a"
wget -O ./data/gag_pol_annotations/HIV1_M_C_gag_pol.gff "$HIV1_M_C_gag_pol_a"
wget -O ./data/gag_pol_annotations/HIV2_A_gag_pol.gff "$HIV2_A_gag_pol_a"
wget -O ./data/gag_pol_annotations/HIV2_B_gag_pol.gff "$HIV2_B_gag_pol_a"
wget -O ./data/gag_pol_annotations/SIV_cpz_gag_pol.gff "$SIV_cpz_gag_pol_a"

echo "Downloading Env protein annotations..."
wget -O ./data/env_annotations/HIV1_M_B_env.gff "$HIV1_M_B_env_a"
wget -O ./data/env_annotations/HIV1_M_C_env.gff "$HIV1_M_C_env_a"
wget -O ./data/env_annotations/HIV2_A_env.gff "$HIV2_A_env_a"
wget -O ./data/env_annotations/HIV2_B_env.gff "$HIV2_B_env_a"
wget -O ./data/env_annotations/SIV_cpz_env.gff "$SIV_cpz_env_a"

echo "Sorting and indexing genome annotations..."
# HIV-1
gunzip -c ./data/hiv1_data/hiv1_annotations.gff > ./data/hiv1_data/hiv1_annotations.gff
jbrowse sort-gff ./data/hiv1_data/hiv1_annotations.gff > ./data/hiv1_data/hiv1_sorted_annotations.gff
tabix ./data/hiv1_data/hiv1_sorted_annotations.gff.gz
rm ./data/hiv1_data/hiv1_annotations.gff.gz ./data/hiv1_data/hiv1_sorted_annotations.gff.gz

# HIV-2
gunzip -c ./data/hiv2_data/hiv2_annotations.gff.gz > ./data/hiv2_data/hiv2_annotations.gff
jbrowse sort-gff ./data/hiv2_data/hiv2_annotations.gff > ./data/hiv2_data/hiv2_sorted_annotations.gff
tabix ./data/hiv2_data/hiv2_sorted_annotations.gff.gz
rm ./data/hiv2_data/hiv2_annotations.gff ./data/hiv2_data/hiv2_sorted_annotations.gff

# SIV
gunzip -c ./data/siv_data/siv_annotations.gff.gz > ./data/siv_data/siv_annotations.gff
jbrowse sort-gff ./data/siv_data/siv_annotations.gff > ./data/siv_data/siv_sorted_annotations.gff
tabix ./data/siv_data/siv_sorted_annotations.gff.gz
rm ./data/siv_data/siv_annotations.gff ./data/siv_data/siv_sorted_annotations.gff

echo "Indexing protein sequences..."
# Gag-Pol Proteins
samtools faidx ./data/gag_pol/HIV1_M_B_gag_pol.fasta
samtools faidx ./data/gag_pol/HIV1_M_C_gag_pol.fasta
samtools faidx ./data/gag_pol/HIV2_A_gag_pol.fasta
samtools faidx ./data/gag_pol/HIV2_B_gag_pol.fasta
samtools faidx ./data/gag_pol/SIV_cpz_gag_pol.fasta

# Env Proteins
samtools faidx ./data/env/HIV1_M_B_env.fasta
samtools faidx ./data/env/HIV1_M_C_env.fasta
samtools faidx ./data/env/HIV2_A_env.fasta
samtools faidx ./data/env/HIV2_B_env.fasta
samtools faidx ./data/env/SIV_cpz_env.fasta

echo "Sorting and indexing protein annotations..."
# Gag-Pol Annotations
jbrowse sort-gff ./data/gag_pol_annotations/HIV1_M_B_gag_pol.gff > ./data/gag_pol_annotations/HIV1_M_B_gag_pol_sorted.gff
bgzip -c ./data/gag_pol_annotations/HIV1_M_B_gag_pol_sorted.gff > ./data/gag_pol_annotations/HIV1_M_B_gag_pol_sorted.gff.gz
tabix ./data/gag_pol_annotations/HIV1_M_B_gag_pol_sorted.gff.gz
rm ./data/gag_pol_annotations/HIV1_M_B_gag_pol.gff ./data/gag_pol_annotations/HIV1_M_B_gag_pol_sorted.gff

jbrowse sort-gff ./data/gag_pol_annotations/HIV1_M_C_gag_pol.gff > ./data/gag_pol_annotations/HIV1_M_C_gag_pol_sorted.gff
bgzip -c ./data/gag_pol_annotations/HIV1_M_C_gag_pol_sorted.gff > ./data/gag_pol_annotations/HIV1_M_C_gag_pol_sorted.gff.gz
tabix ./data/gag_pol_annotations/HIV1_M_C_gag_pol_sorted.gff.gz
rm ./data/gag_pol_annotations/HIV1_M_C_gag_pol.gff ./data/gag_pol_annotations/HIV1_M_C_gag_pol_sorted.gff

jbrowse sort-gff ./data/gag_pol_annotations/HIV2_A_gag_pol.gff > ./data/gag_pol_annotations/HIV2_A_gag_pol_sorted.gff
bgzip -c ./data/gag_pol_annotations/HIV2_A_gag_pol_sorted.gff > ./data/gag_pol_annotations/HIV2_A_gag_pol_sorted.gff.gz
tabix ./data/gag_pol_annotations/HIV2_A_gag_pol_sorted.gff.gz
rm ./data/gag_pol_annotations/HIV2_A_gag_pol.gff ./data/gag_pol_annotations/HIV2_A_gag_pol_sorted.gff

jbrowse sort-gff ./data/gag_pol_annotations/HIV2_B_gag_pol.gff > ./data/gag_pol_annotations/HIV2_B_gag_pol_sorted.gff
bgzip -c ./data/gag_pol_annotations/HIV2_B_gag_pol_sorted.gff > ./data/gag_pol_annotations/HIV2_B_gag_pol_sorted.gff.gz
tabix ./data/gag_pol_annotations/HIV2_B_gag_pol_sorted.gff.gz
rm ./data/gag_pol_annotations/HIV2_B_gag_pol.gff ./data/gag_pol_annotations/HIV2_B_gag_pol_sorted.gff

jbrowse sort-gff ./data/gag_pol_annotations/SIV_cpz_gag_pol.gff > ./data/gag_pol_annotations/SIV_cpz_gag_pol_sorted.gff
bgzip -c ./data/gag_pol_annotations/SIV_cpz_gag_pol_sorted.gff > ./data/gag_pol_annotations/SIV_cpz_gag_pol_sorted.gff.gz
tabix ./data/gag_pol_annotations/SIV_cpz_gag_pol_sorted.gff.gz
rm ./data/gag_pol_annotations/SIV_cpz_gag_pol.gff ./data/gag_pol_annotations/SIV_cpz_gag_pol_sorted.gff

# Env Annotations
jbrowse sort-gff ./data/env_annotations/HIV1_M_B_env.gff > ./data/env_annotations/HIV1_M_B_env_sorted.gff
bgzip -c ./data/env_annotations/HIV1_M_B_env_sorted.gff > ./data/env_annotations/HIV1_M_B_env_sorted.gff.gz
tabix ./data/env_annotations/HIV1_M_B_env_sorted.gff.gz
rm ./data/env_annotations/HIV1_M_B_env.gff ./data/env_annotations/HIV1_M_B_env_sorted.gff

jbrowse sort-gff ./data/env_annotations/HIV1_M_C_env.gff > ./data/env_annotations/HIV1_M_C_env_sorted.gff
bgzip -c ./data/env_annotations/HIV1_M_C_env_sorted.gff > ./data/env_annotations/HIV1_M_C_env_sorted.gff.gz
tabix ./data/env_annotations/HIV1_M_C_env_sorted.gff.gz
rm ./data/env_annotations/HIV1_M_C_env.gff ./data/env_annotations/HIV1_M_C_env_sorted.gff

jbrowse sort-gff ./data/env_annotations/HIV2_A_env.gff > ./data/env_annotations/HIV2_A_env_sorted.gff
bgzip -c ./data/env_annotations/HIV2_A_env_sorted.gff > ./data/env_annotations/HIV2_A_env_sorted.gff.gz
tabix ./data/env_annotations/HIV2_A_env_sorted.gff.gz
rm ./data/env_annotations/HIV2_A_env.gff ./data/env_annotations/HIV2_A_env_sorted.gff

jbrowse sort-gff ./data/env_annotations/HIV2_B_env.gff > ./data/env_annotations/HIV2_B_env_sorted.gff
bgzip -c ./data/env_annotations/HIV2_B_env_sorted.gff > ./data/env_annotations/HIV2_B_env_sorted.gff.gz
tabix ./data/env_annotations/HIV2_B_env_sorted.gff.gz
rm ./data/env_annotations/HIV2_B_env.gff ./data/env_annotations/HIV2_B_env_sorted.gff

jbrowse sort-gff ./data/env_annotations/SIV_cpz_env.gff > ./data/env_annotations/SIV_cpz_env_sorted.gff
bgzip -c ./data/env_annotations/SIV_cpz_env_sorted.gff > ./data/env_annotations/SIV_cpz_env_sorted.gff.gz
tabix ./data/env_annotations/SIV_cpz_env_sorted.gff.gz
rm ./data/env_annotations/SIV_cpz_env.gff ./data/env_annotations/SIV_cpz_env_sorted.gff



echo "Creating text index for JBrowse..."
jbrowse text-index --target ./ --force

echo "All done!"

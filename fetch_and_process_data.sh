#!/bin/bash

# Genome and Annotation Fetching Script

# Ensure required tools (wget, samtools, jbrowse) are installed before running this script.
# need minimap 2 for synteny tracks 
# Run this script in the jbrowse2 directory:
# chmod +x fetch_and_process_data.sh && ./fetch_and_process_data.sh

# Navigate to script directory
cd "$(dirname "$0")"

# Create main data directory
mkdir -p ./data


# Reference Genome and Annotation URLs
HIV1_reference_genome="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/864/765/GCF_000864765.1_ViralProj15476/GCF_000864765.1_ViralProj15476_genomic.fna.gz"
HIV1_annotations="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/864/765/GCF_000864765.1_ViralProj15476/GCF_000864765.1_ViralProj15476_genomic.gff.gz"

HIV2_reference_genome="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/856/385/GCF_000856385.1_ViralProj14991/GCF_000856385.1_ViralProj14991_genomic.fna.gz"
HIV2_annotations="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/856/385/GCF_000856385.1_ViralProj14991/GCF_000856385.1_ViralProj14991_genomic.gff.gz"

SIV_reference_genome="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/863/925/GCF_000863925.1_ViralProj15501/GCF_000863925.1_ViralProj15501_genomic.fna.gz"
SIV_annotations="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/863/925/GCF_000863925.1_ViralProj15501/GCF_000863925.1_ViralProj15501_genomic.gff.gz"


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

HIV1_M_B_tat=https://rest.uniprot.org/uniprotkb/P20879.fasta
HIV1_M_B_tat_a=https://rest.uniprot.org/uniprotkb/P20879.gff?fields=ft_var_seq%2Cft_variant%2Cft_non_cons%2Cft_non_std%2Cft_non_ter%2Cft_conflict%2Cft_unsure%2Cft_act_site%2Cft_binding%2Cft_dna_bind%2Cft_site%2Cft_mutagen%2Cft_intramem%2Cft_topo_dom%2Cft_transmem%2Cft_chain%2Cft_crosslnk%2Cft_disulfid%2Cft_carbohyd%2Cft_init_met%2Cft_lipid%2Cft_mod_res%2Cft_peptide%2Cft_propep%2Cft_signal%2Cft_transit%2Cft_strand%2Cft_helix%2Cft_turn%2Cft_coiled%2Cft_compbias%2Cft_domain%2Cft_motif%2Cft_region%2Cft_repeat%2Cft_zn_fing 
HIV1_M_C_tat=https://rest.uniprot.org/uniprotkb/O12161.fasta 
HIV1_M_C_tat_a=https://rest.uniprot.org/uniprotkb/O12161.gff?fields=ft_var_seq%2Cft_variant%2Cft_non_cons%2Cft_non_std%2Cft_non_ter%2Cft_conflict%2Cft_unsure%2Cft_act_site%2Cft_binding%2Cft_dna_bind%2Cft_site%2Cft_mutagen%2Cft_intramem%2Cft_topo_dom%2Cft_transmem%2Cft_chain%2Cft_crosslnk%2Cft_disulfid%2Cft_carbohyd%2Cft_init_met%2Cft_lipid%2Cft_mod_res%2Cft_peptide%2Cft_propep%2Cft_signal%2Cft_transit%2Cft_strand%2Cft_helix%2Cft_turn%2Cft_coiled%2Cft_compbias%2Cft_domain%2Cft_motif%2Cft_region%2Cft_repeat%2Cft_zn_fing 
HIV2_A_tat=https://rest.uniprot.org/uniprotkb/P20880.fasta 
HIV2_A_tat_a=https://rest.uniprot.org/uniprotkb/P20880.gff?fields=ft_var_seq%2Cft_variant%2Cft_non_cons%2Cft_non_std%2Cft_non_ter%2Cft_conflict%2Cft_unsure%2Cft_act_site%2Cft_binding%2Cft_dna_bind%2Cft_site%2Cft_mutagen%2Cft_intramem%2Cft_topo_dom%2Cft_transmem%2Cft_chain%2Cft_crosslnk%2Cft_disulfid%2Cft_carbohyd%2Cft_init_met%2Cft_lipid%2Cft_mod_res%2Cft_peptide%2Cft_propep%2Cft_signal%2Cft_transit%2Cft_strand%2Cft_helix%2Cft_turn%2Cft_coiled%2Cft_compbias%2Cft_domain%2Cft_motif%2Cft_region%2Cft_repeat%2Cft_zn_fing 
HIV2_B_tat=https://rest.uniprot.org/uniprotkb/P15835.fasta 
HIV2_B_tat_a=https://rest.uniprot.org/uniprotkb/P15835.gff?fields=ft_var_seq%2Cft_variant%2Cft_non_cons%2Cft_non_std%2Cft_non_ter%2Cft_conflict%2Cft_unsure%2Cft_act_site%2Cft_binding%2Cft_dna_bind%2Cft_site%2Cft_mutagen%2Cft_intramem%2Cft_topo_dom%2Cft_transmem%2Cft_chain%2Cft_crosslnk%2Cft_disulfid%2Cft_carbohyd%2Cft_init_met%2Cft_lipid%2Cft_mod_res%2Cft_peptide%2Cft_propep%2Cft_signal%2Cft_transit%2Cft_strand%2Cft_helix%2Cft_turn%2Cft_coiled%2Cft_compbias%2Cft_domain%2Cft_motif%2Cft_region%2Cft_repeat%2Cft_zn_fing 
SIV_cpz_env=https://rest.uniprot.org/uniprotkb/Q1A264.fasta
SIV_cpz_env_a=https://rest.uniprot.org/uniprotkb/Q1A264.gff?fields=ft_var_seq%2Cft_variant%2Cft_non_cons%2Cft_non_std%2Cft_non_ter%2Cft_conflict%2Cft_unsure%2Cft_act_site%2Cft_binding%2Cft_dna_bind%2Cft_site%2Cft_mutagen%2Cft_intramem%2Cft_topo_dom%2Cft_transmem%2Cft_chain%2Cft_crosslnk%2Cft_disulfid%2Cft_carbohyd%2Cft_init_met%2Cft_lipid%2Cft_mod_res%2Cft_peptide%2Cft_propep%2Cft_signal%2Cft_transit%2Cft_strand%2Cft_helix%2Cft_turn%2Cft_coiled%2Cft_compbias%2Cft_domain%2Cft_motif%2Cft_region%2Cft_repeat%2Cft_zn_fing


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


# Directory Setup

if [[ -d "./data/hiv1_data" && -d "./data/hiv2_data" && -d "./data/siv_data" && \
      -d "./data/gag_pol" && -d "./data/env" && -d "./data/tat" && -d "./trix" && \
      -d "./data/gag_pol_annotations" && -d "./data/env_annotations" && -d "./data/tat_annotations" ]]; then
    exit 0
fi

mkdir -p ./data/hiv1_data ./data/hiv2_data ./data/siv_data
mkdir -p ./data/gag_pol ./data/env ./data/tat
mkdir -p ./data/gag_pol_annotations ./data/env_annotations ./data/tat_annotations


# Download Reference Genomes and Annotations

wget -O ./data/hiv1_data/hiv1_genome.fna.gz "$HIV1_reference_genome"
gunzip -f ./data/hiv1_data/hiv1_genome.fna.gz
samtools faidx ./data/hiv1_data/hiv1_genome.fna
wget -O ./data/hiv2_data/hiv2_genome.fna.gz "$HIV2_reference_genome"
gunzip -f ./data/hiv2_data/hiv2_genome.fna.gz
samtools faidx ./data/hiv2_data/hiv2_genome.fna
wget -O ./data/siv_data/siv_genome.fna.gz "$SIV_reference_genome"
gunzip -f ./data/siv_data/siv_genome.fna.gz
samtools faidx ./data/siv_data/siv_genome.fna

wget -O ./data/hiv1_data/hiv1_annotations.gff.gz "$HIV1_annotations"
wget -O ./data/hiv2_data/hiv2_annotations.gff.gz "$HIV2_annotations"
wget -O ./data/siv_data/siv_annotations.gff.gz "$SIV_annotations"


# Download Protein Sequences and Annotations

wget -O ./data/gag_pol/HIV1_M_B_gag_pol.fasta "$HIV1_M_B_gag_pol"
wget -O ./data/gag_pol/HIV1_M_C_gag_pol.fasta "$HIV1_M_C_gag_pol"
wget -O ./data/gag_pol/HIV2_A_gag_pol.fasta "$HIV2_A_gag_pol"
wget -O ./data/gag_pol/HIV2_B_gag_pol.fasta "$HIV2_B_gag_pol"
wget -O ./data/gag_pol/SIV_cpz_gag_pol.fasta "$SIV_cpz_gag_pol"


wget -O ./data/env/HIV1_M_B_env.fasta "$HIV1_M_B_env"
wget -O ./data/env/HIV1_M_C_env.fasta "$HIV1_M_C_env"
wget -O ./data/env/HIV2_A_env.fasta "$HIV2_A_env"
wget -O ./data/env/HIV2_B_env.fasta "$HIV2_B_env"
wget -O ./data/env/SIV_cpz_env.fasta "$SIV_cpz_env"

wget -O ./data/tat/HIV1_M_B_tat.fasta "$HIV1_M_B_tat"
wget -O ./data/tat/HIV1_M_C_tat.fasta "$HIV1_M_C_tat"
wget -O ./data/tat/HIV2_A_tat.fasta "$HIV2_A_tat"
wget -O ./data/tat/HIV2_B_tat.fasta "$HIV2_B_tat"
wget -O ./data/tat/SIV_cpz_tat.fasta "$SIV_cpz_tat"



wget -O ./data/gag_pol_annotations/HIV1_M_B_gag_pol.gff "$HIV1_M_B_gag_pol_a"
wget -O ./data/gag_pol_annotations/HIV1_M_C_gag_pol.gff "$HIV1_M_C_gag_pol_a"
wget -O ./data/gag_pol_annotations/HIV2_A_gag_pol.gff "$HIV2_A_gag_pol_a"
wget -O ./data/gag_pol_annotations/HIV2_B_gag_pol.gff "$HIV2_B_gag_pol_a"
wget -O ./data/gag_pol_annotations/SIV_cpz_gag_pol.gff "$SIV_cpz_gag_pol_a"


wget -O ./data/env_annotations/HIV1_M_B_env.gff "$HIV1_M_B_env_a"
wget -O ./data/env_annotations/HIV1_M_C_env.gff "$HIV1_M_C_env_a"
wget -O ./data/env_annotations/HIV2_A_env.gff "$HIV2_A_env_a"
wget -O ./data/env_annotations/HIV2_B_env.gff "$HIV2_B_env_a"
wget -O ./data/env_annotations/SIV_cpz_env.gff "$SIV_cpz_env_a"

wget -O ./data/tat_annotations/HIV1_M_B_tat.gff "$HIV1_M_B_tat_a"
wget -O ./data/tat_annotations/HIV1_M_C_tat.gff "$HIV1_M_C_tat_a"
wget -O ./data/tat_annotations/HIV2_A_tat.gff "$HIV2_A_tat_a"
wget -O ./data/tat_annotations/HIV2_B_tat.gff "$HIV2_B_tat_a"
wget -O ./data/tat_annotations/SIV_cpz_tat.gff "$SIV_cpz_tat_a"





# HIV-1
gunzip -c ./data/hiv1_data/hiv1_annotations.gff.gz > ./data/hiv1_data/hiv1_annotations.gff
jbrowse sort-gff ./data/hiv1_data/hiv1_annotations.gff > ./data/hiv1_data/hiv1_sorted_annotations.gff
bgzip -c ./data/hiv1_data/hiv1_sorted_annotations.gff > ./data/hiv1_data/hiv1_sorted_annotations.gff.gz 
tabix ./data/hiv1_data/hiv1_sorted_annotations.gff.gz
rm ./data/hiv1_data/hiv1_annotations.gff ./data/hiv1_data/hiv1_sorted_annotations.gff

# HIV-2
gunzip -c ./data/hiv2_data/hiv2_annotations.gff.gz > ./data/hiv2_data/hiv2_annotations.gff
jbrowse sort-gff ./data/hiv2_data/hiv2_annotations.gff > ./data/hiv2_data/hiv2_sorted_annotations.gff
bgzip -c ./data/hiv2_data/hiv2_sorted_annotations.gff > ./data/hiv2_data/hiv2_sorted_annotations.gff.gz
tabix ./data/hiv2_data/hiv2_sorted_annotations.gff.gz
rm ./data/hiv2_data/hiv2_annotations.gff ./data/hiv2_data/hiv2_sorted_annotations.gff

# SIV
gunzip -c ./data/siv_data/siv_annotations.gff.gz > ./data/siv_data/siv_annotations.gff
jbrowse sort-gff ./data/siv_data/siv_annotations.gff > ./data/siv_data/siv_sorted_annotations.gff
bgzip -c ./data/siv_data/siv_sorted_annotations.gff > ./data/siv_data/siv_sorted_annotations.gff.gz  # Compress the sorted GFF
tabix ./data/siv_data/siv_sorted_annotations.gff.gz
rm ./data/siv_data/siv_annotations.gff ./data/siv_data/siv_sorted_annotations.gff

# Aligning the fasta and gff names for protien data 
fasta_files=(
  "./data/gag_pol/HIV1_M_B_gag_pol.fasta"
  "./data/gag_pol/HIV1_M_C_gag_pol.fasta"
  "./data/gag_pol/HIV2_A_gag_pol.fasta"
  "./data/gag_pol/HIV2_B_gag_pol.fasta"
  "./data/gag_pol/SIV_cpz_gag_pol.fasta"
  "./data/env/HIV1_M_B_env.fasta"
  "./data/env/HIV1_M_C_env.fasta"
  "./data/env/HIV2_A_env.fasta"
  "./data/env/HIV2_B_env.fasta"
  "./data/env/SIV_cpz_env.fasta"
  "./data/tat/HIV1_M_B_tat.fasta"
  "./data/tat/HIV1_M_C_tat.fasta"
  "./data/tat/HIV2_A_tat.fasta"
  "./data/tat/HIV2_B_tat.fasta"
  "./data/tat/SIV_cpz_tat.fasta"

)

gff_files=(
  "./data/gag_pol_annotations/HIV1_M_B_gag_pol.gff"
  "./data/gag_pol_annotations/HIV1_M_C_gag_pol.gff"
  "./data/gag_pol_annotations/HIV2_A_gag_pol.gff"
  "./data/gag_pol_annotations/HIV2_B_gag_pol.gff"
  "./data/gag_pol_annotations/SIV_cpz_gag_pol.gff"
  "./data/env_annotations/HIV1_M_B_env.gff"
  "./data/env_annotations/HIV1_M_C_env.gff"
  "./data/env_annotations/HIV2_A_env.gff"
  "./data/env_annotations/HIV2_B_env.gff"
  "./data/env_annotations/SIV_cpz_env.gff"
  "./data/tat_annotations/HIV1_M_B_tat.gff"
  "./data/tat_annotations/HIV1_M_C_tat.gff"
  "./data/tat_annotations/HIV2_A_tat.gff"
  "./data/tat_annotations/HIV2_B_tat.gff"
  "./data/tat_annotations/SIV_cpz_tat.gff"
)

# Function to process a single FASTA and GFF pair
process_fasta_and_gff() {
  local fasta_file="$1"
  local gff_file="$2"
  local updated_fasta="${fasta_file%.fasta}_updated.fasta"

  # Check if both files exist
  if [[ ! -f "$fasta_file" ]]; then
    echo "Error: FASTA file $fasta_file not found. Skipping..."
    return
  fi

  if [[ ! -f "$gff_file" ]]; then
    echo "Error: GFF file $gff_file not found. Skipping..."
    return
  fi

  # Extract SEQID from the GFF file
  SEQID=$(awk '{if ($1 !~ /^#/) {print $1; exit}}' "$gff_file")
  if [[ -z "$SEQID" ]]; then
    echo "Error: Could not extract SEQID from $gff_file. Skipping..."
    return
  fi

  # Check and update FASTA header if necessary
  CURRENT_HEADER=$(head -n 1 "$fasta_file" | sed 's/^>//')
  if [[ "$CURRENT_HEADER" != "$SEQID" ]]; then
    echo "Updating FASTA header in $fasta_file from '$CURRENT_HEADER' to '$SEQID'..."
    sed "1s/>.*/>$SEQID/" "$fasta_file" > "$updated_fasta"
    mv "$updated_fasta" "$fasta_file"
    echo "FASTA header updated successfully!"
  else
    echo "FASTA header in $fasta_file already matches GFF seqid: '$SEQID'. No changes needed."
  fi
}

# Iterate over the arrays
for i in "${!fasta_files[@]}"; do
  process_fasta_and_gff "${fasta_files[$i]}" "${gff_files[$i]}"
done


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

#Tat protiens
samtools faidx ./data/tat/HIV1_M_B_tat.fasta
samtools faidx ./data/tat/HIV1_M_C_tat.fasta
samtools faidx ./data/tat/HIV2_A_tat.fasta
samtools faidx ./data/tat/HIV2_B_tat.fasta
samtools faidx ./data/tat/SIV_cpz_tat.fasta


# Gag-Pol Annotations
jbrowse sort-gff ./data/gag_pol_annotations/HIV1_M_B_gag_pol.gff > ./data/gag_pol_annotations/HIV1_M_B_gag_pol_sorted.gff
bgzip -c ./data/gag_pol_annotations/HIV1_M_B_gag_pol_sorted.gff > ./data/gag_pol_annotations/HIV1_M_B_gag_pol_sorted.gff.gz
tabix ./data/gag_pol_annotations/HIV1_M_B_gag_pol_sorted.gff.gz
#rm ./data/gag_pol_annotations/HIV1_M_B_gag_pol.gff ./data/gag_pol_annotations/HIV1_M_B_gag_pol_sorted.gff

jbrowse sort-gff ./data/gag_pol_annotations/HIV1_M_C_gag_pol.gff > ./data/gag_pol_annotations/HIV1_M_C_gag_pol_sorted.gff
bgzip -c ./data/gag_pol_annotations/HIV1_M_C_gag_pol_sorted.gff > ./data/gag_pol_annotations/HIV1_M_C_gag_pol_sorted.gff.gz
tabix ./data/gag_pol_annotations/HIV1_M_C_gag_pol_sorted.gff.gz
#rm ./data/gag_pol_annotations/HIV1_M_C_gag_pol.gff ./data/gag_pol_annotations/HIV1_M_C_gag_pol_sorted.gff

jbrowse sort-gff ./data/gag_pol_annotations/HIV2_A_gag_pol.gff > ./data/gag_pol_annotations/HIV2_A_gag_pol_sorted.gff
bgzip -c ./data/gag_pol_annotations/HIV2_A_gag_pol_sorted.gff > ./data/gag_pol_annotations/HIV2_A_gag_pol_sorted.gff.gz
tabix ./data/gag_pol_annotations/HIV2_A_gag_pol_sorted.gff.gz
#rm ./data/gag_pol_annotations/HIV2_A_gag_pol.gff ./data/gag_pol_annotations/HIV2_A_gag_pol_sorted.gff

jbrowse sort-gff ./data/gag_pol_annotations/HIV2_B_gag_pol.gff > ./data/gag_pol_annotations/HIV2_B_gag_pol_sorted.gff
bgzip -c ./data/gag_pol_annotations/HIV2_B_gag_pol_sorted.gff > ./data/gag_pol_annotations/HIV2_B_gag_pol_sorted.gff.gz
tabix ./data/gag_pol_annotations/HIV2_B_gag_pol_sorted.gff.gz
#rm ./data/gag_pol_annotations/HIV2_B_gag_pol.gff ./data/gag_pol_annotations/HIV2_B_gag_pol_sorted.gff

jbrowse sort-gff ./data/gag_pol_annotations/SIV_cpz_gag_pol.gff > ./data/gag_pol_annotations/SIV_cpz_gag_pol_sorted.gff
bgzip -c ./data/gag_pol_annotations/SIV_cpz_gag_pol_sorted.gff > ./data/gag_pol_annotations/SIV_cpz_gag_pol_sorted.gff.gz
tabix ./data/gag_pol_annotations/SIV_cpz_gag_pol_sorted.gff.gz
#rm ./data/gag_pol_annotations/HIV2_B_gag_pol.gff ./data/gag_pol_annotations/HIV2_B_gag_pol_sorted.gff

# Env Annotations
jbrowse sort-gff ./data/env_annotations/HIV1_M_B_env.gff > ./data/env_annotations/HIV1_M_B_env_sorted.gff
bgzip -c ./data/env_annotations/HIV1_M_B_env_sorted.gff > ./data/env_annotations/HIV1_M_B_env_sorted.gff.gz
tabix ./data/env_annotations/HIV1_M_B_env_sorted.gff.gz
#rm ./data/env_annotations/HIV1_M_B_env.gff ./data/env_annotations/HIV1_M_B_env_sorted.gff

jbrowse sort-gff ./data/env_annotations/HIV1_M_C_env.gff > ./data/env_annotations/HIV1_M_C_env_sorted.gff
bgzip -c ./data/env_annotations/HIV1_M_C_env_sorted.gff > ./data/env_annotations/HIV1_M_C_env_sorted.gff.gz
tabix ./data/env_annotations/HIV1_M_C_env_sorted.gff.gz
#rm ./data/env_annotations/HIV1_M_C_env.gff ./data/env_annotations/HIV1_M_C_env_sorted.gff

jbrowse sort-gff ./data/env_annotations/HIV2_A_env.gff > ./data/env_annotations/HIV2_A_env_sorted.gff
bgzip -c ./data/env_annotations/HIV2_A_env_sorted.gff > ./data/env_annotations/HIV2_A_env_sorted.gff.gz
tabix ./data/env_annotations/HIV2_A_env_sorted.gff.gz
#rm ./data/env_annotations/HIV2_A_env.gff ./data/env_annotations/HIV2_A_env_sorted.gff

jbrowse sort-gff ./data/env_annotations/HIV2_B_env.gff > ./data/env_annotations/HIV2_B_env_sorted.gff
bgzip -c ./data/env_annotations/HIV2_B_env_sorted.gff > ./data/env_annotations/HIV2_B_env_sorted.gff.gz
tabix ./data/env_annotations/HIV2_B_env_sorted.gff.gz
#rm ./data/env_annotations/HIV2_B_env.gff ./data/env_annotations/HIV2_B_env_sorted.gff

jbrowse sort-gff ./data/env_annotations/SIV_cpz_env.gff > ./data/env_annotations/SIV_cpz_env_sorted.gff
bgzip -c ./data/env_annotations/SIV_cpz_env_sorted.gff > ./data/env_annotations/SIV_cpz_env_sorted.gff.gz
tabix ./data/env_annotations/SIV_cpz_env_sorted.gff.gz
#rm ./data/env_annotations/SIV_cpz_env.gff ./data/env_annotations/SIV_cpz_env_sorted.gff



jbrowse sort-gff ./data/tat_annotations/HIV1_M_B_tat.gff > ./data/tat_annotations/HIV1_M_B_tat_sorted.gff
bgzip -c ./data/tat_annotations/HIV1_M_B_tat_sorted.gff > ./data/tat_annotations/HIV1_M_B_tat_sorted.gff.gz
tabix ./data/tat_annotations/HIV1_M_B_tat_sorted.gff.gz
#rm ./data/env_annotations/HIV1_M_B_env.gff ./data/env_annotations/HIV1_M_B_env_sorted.gff

jbrowse sort-gff ./data/tat_annotations/HIV1_M_C_tat.gff > ./data/tat_annotations/HIV1_M_C_tat_sorted.gff
bgzip -c ./data/tat_annotations/HIV1_M_C_tat_sorted.gff > ./data/tat_annotations/HIV1_M_C_tat_sorted.gff.gz
tabix ./data/tat_annotations/HIV1_M_C_tat_sorted.gff.gz
#rm ./data/env_annotations/HIV1_M_C_env.gff ./data/env_annotations/HIV1_M_C_env_sorted.gff

jbrowse sort-gff ./data/tat_annotations/HIV2_A_tat.gff > ./data/tat_annotations/HIV2_A_tat_sorted.gff
bgzip -c ./data/tat_annotations/HIV2_A_tat_sorted.gff > ./data/tat_annotations/HIV2_A_tat_sorted.gff.gz
tabix ./data/tat_annotations/HIV2_A_tat_sorted.gff.gz
#rm ./data/env_annotations/HIV2_A_env.gff ./data/env_annotations/HIV2_A_env_sorted.gff

jbrowse sort-gff ./data/tat_annotations/HIV2_B_tat.gff > ./data/tat_annotations/HIV2_B_tat_sorted.gff
bgzip -c ./data/tat_annotations/HIV2_B_tat_sorted.gff > ./data/tat_annotations/HIV2_B_tat_sorted.gff.gz
tabix ./data/tat_annotations/HIV2_B_tat_sorted.gff.gz
#rm ./data/env_annotations/HIV2_B_env.gff ./data/env_annotations/HIV2_B_env_sorted.gff

jbrowse sort-gff ./data/tat_annotations/SIV_cpz_tat.gff > ./data/tat_annotations/SIV_cpz_tat_sorted.gff
bgzip -c ./data/tat_annotations/SIV_cpz_tat_sorted.gff > ./data/tat_annotations/SIV_cpz_tat_sorted.gff.gz
tabix ./data/tat_annotations/SIV_cpz_tat_sorted.gff.gz
#rm ./data/env_annotations/SIV_cpz_env.gff ./data/env_annotations/SIV_cpz_env_sorted.gff

#creating and adding synteny data 
mkdir -p ./data/synteny

#genomes 
minimap2 data/hiv2_data/hiv2_genome.fna data/hiv1_data/hiv1_genome.fna > data/synteny/hiv1_vs_hiv2.paf
minimap2 data/siv_data/siv_genome.fna data/hiv1_data/hiv1_genome.fna > data/synteny/hiv1_vs_siv.paf
minimap2 data/siv_data/siv_genome.fna data/hiv2_data/hiv2_genome.fna > data/synteny/hiv2_vs_siv.paf
minimap2 data/hiv1_data/hiv1_genome.fna data/hiv2_data/hiv2_genome.fna > data/synteny/hiv2_vs_hiv1.paf
minimap2 data/hiv1_data/hiv1_genome.fna data/siv_data/siv_genome.fna > data/synteny/siv_vs_hiv1.paf
minimap2 data/hiv2_data/hiv2_genome.fna data/siv_data/siv_genome.fna > data/synteny/siv_vs_hiv2.paf


echo "Creating text index for JBrowse..."
jbrowse text-index --target ./ --force

echo "All done!"
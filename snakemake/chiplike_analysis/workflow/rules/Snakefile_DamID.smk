# June2, 2021
# ChIPSeq like data analysis pipeline
# Functions: 
    # fastqc
    # map, filter, bam_qc
    # call peak: sample level and contrast based (read contras.csv and meta.csv)
    # bigwig (macs2_DamID signal based)
# Env: 
    # source activate chiplike
# Requirements
    # inputs in ./fastq/
    # named as {sample}.{R1,R2}.{fastq,fq}.gz
    # e.g. A.R1.fastq.gz A.R2.fastq.gz B...
    # good format of meta.csv and contrast.csv, matching SAMPLES in config.yaml


from snakemake.utils import min_version
from modules import parse_meta_contrast, get_treatment_bams_from_contrast, \
    get_control_bams_from_contrast, get_contrast_name_from_contrast, \
    get_treat_pileup_bw_names_from_contrasts, \
    get_control_lambda_bw_names_from_contrasts


### parse and prepare
min_version("5.17.0")

configfile: "config/config.yaml"
DATA_TYPE=config['DATA_TYPE']
MODE=config['MODE']
SAMPLES=config["SAMPLES"]
GENOME=config["GENOME"]
INDEX=GENOME+".sa"
MQ_MIN=config["MQ_MIN"]
BIN_SIZE=config["BIN_SIZE"]
GSIZE=config["GSIZE"]
SizeFile=config["SizeFile"]
MEME_DB=config["MEME_DB"]
PEAK_WIDTH=config['PEAK_WIDTH']
CHRS=config['CHRS']
minFragmentLength=config['minFragmentLength']
maxFragmentLength=config['maxFragmentLength']
BW_BIN_SIZE=config['BW_BIN_SIZE']

#o=parse_meta_contrast(fmeta=pwd+"/config/meta.csv", fcontrast=pwd + "/config/contrast.csv") 
# print("parse_meta_contrast_obj:", vars(o))
# {'contrast2contrast_name': {'contrast1': 'G1_vs_ctrl', 'contrast2': 'G2_vs_ctrl', 'contrast3': 'G1_G2_vs_ctrl'}, 
# 'contrast2treatmentSamples': {'contrast1': ['2-1_S2', '2-2_S3', '2-3_S4'], 'contrast2': ['3-1_S5', '3-2_S6', '3-3_S7']}, 
# 'contrast2controlSamples': {'contrast1': ['1-2_S1'], 'contrast2': ['1-2_S1'], 'contrast3': ['1-2_S1']}}

    


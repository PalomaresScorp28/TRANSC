#!/bin/bash

SORTMERNA_DB="/home/pscorp28/rRNA_database"
MERGED_FILES="/home/pscorp28/step_2_output"
RIBODEPLETED_FILES="/home/pscorp28/step_3_output"
RIBOSOMAL_FILES="/home/pscorp28/sortme-ribosomes"
HUMAN_FILTERED="/home/pscorp28/human_filtered"
HUMAN_DB="/home/pscorp28/hg37-human-db"

#Download the human (hg37_and_human_contamination) reference database (approx. size = 3.5 GB).
#This database is based on the Decoy Genome (http://www.cureffi.org/2013/02/01/the-decoy-genome/) and contaminants taken from “Human contamination in bacterial genomes #has created thousands of spurious proteins” (Salzberg et. al. 2019)

#kneaddata_database --download human_genome bowtie2 $HUMAN

#The human transcriptome (hg38) reference database is also available for download (approx. size = 254 MB).

kneaddata_database --download human_transcriptome bowtie2 $HUMAN_DB

#Select Reference Sequences
#First you must select reference sequences for the contamination you are trying to remove. Say you wish to filter reads from a particular "host." 
#Broadly defined, the host can be an organism, or a set of organisms, or just a set of sequences. Then, you simply must generate a reference database for KneadData 
#from a FASTA file containing these sequences. Usually, researchers want to remove reads from the human genome, the human transcriptome, or ribosomal RNA. 

#To download the indexed human reference database, run the following command:

#kneaddata_database --download human bowtie2 $HUMAN_DB

#How to Run

#After downloading or generating your database file, you can start to remove contaminant reads. As input, KneadData requires FASTQ files. It supports both single end and paired end reads. KneadData uses either Bowtie2 (default) or BMTagger to identify the contaminant reads.
#Single End Run


for file in $RIBODEPLETED_FILES/*ribodepleted*
do
 shortname=`echo $file | awk -F ".ribodepleted" '{print $1 ".decontaminated"}'`
 kneaddata --bypass-trim --bypass-trf \
 --reference-db $HUMAN_DB/human_hg38_refMrna.1.bt2 \
 --reference-db $HUMAN_DB/human_hg38_refMrna.2.bt2 \
 --reference-db $HUMAN_DB/human_hg38_refMrna.3.bt2 \
 --reference-db $HUMAN_DB/human_hg38_refMrna.4.bt2 \
 --reference-db $HUMAN_DB/human_hg38_refMrna.rev.1.bt2 \
 --reference-db $HUMAN_DB/human_hg38_refMrna.rev.2.bt2 \
 --input $file --output $HUMAN_FILTERED/$shortname -v --threads 14
done


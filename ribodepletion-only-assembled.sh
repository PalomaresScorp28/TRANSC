#!/bin/bash

threads=`getconf _NPROCESSORS_ONLN`

rm -r $HOME/sortmerna

META=$HOME/metatranscriptomics
DATABASES="$META/databases"
SORTMERNA_DB="$DATABASES/rRNA_database"
MERGED_FILES="$META/02_only_merged_reads"
RIBODEPLETED_FILES="$META/03_ribodepleted_only_merged"
RIBOSOMAL_FILES="$META/03.2_rrna-reads"

for file in $MERGED_FILES/*.assembled.fastq
do
rm -r $HOME/sortmerna
shortname=`echo $file | awk -F "assembled" '{print $1 "ribodepleted"}'`
sortmerna -ref $SORTMERNA_DB/rfam-5.8s-database-id98.fasta \
-ref $SORTMERNA_DB/rfam-5s-database-id98.fasta \
-ref $SORTMERNA_DB/silva-arc-16s-id95.fasta \
-ref $SORTMERNA_DB/silva-arc-23s-id98.fasta \
-ref $SORTMERNA_DB/silva-bac-16s-id90.fasta \
-ref $SORTMERNA_DB/silva-bac-23s-id98.fasta \
-ref $SORTMERNA_DB/silva-euk-18s-id95.fasta \
-ref $SORTMERNA_DB/silva-euk-28s-id98.fasta \
-reads $file --aligned $file.ribosomes --other $shortname --fastx --threads $threads -v
done

mv $MERGED_FILES/*ribodeplete* $RIBODEPLETED_FILES

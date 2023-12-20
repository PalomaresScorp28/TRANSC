#!/bin/bash

rm -r $HOME/sortmerna

META=$HOME/metatranscriptomics
DATABASES="$META/databases"
SORTMERNA_DB="$DATABASES/rRNA_database"
MERGED_FILES="$META/02_assembled-reads"
RIBODEPLETED_FILES="$META/03_ribodepleted-reads"
RIBOSOMAL_FILES="$META/03.1_rrna-reads"

for file in $MERGED_FILES/*.assembled2.fastq
do
shortname=`echo $file | awk -F "a no" '{print $1 "ribodepleted"}'`
sortmerna -ref $SORTMERNA_DB/rfam-5.8s-database-id98.fasta \
-ref $SORTMERNA_DB/rfam-5s-database-id98.fasta \
-ref $SORTMERNA_DB/silva-arc-16s-id95.fasta \
-ref $SORTMERNA_DB/silva-arc-23s-id98.fasta \
-ref $SORTMERNA_DB/silva-bac-16s-id90.fasta \
-ref $SORTMERNA_DB/silva-bac-23s-id98.fasta \
-ref $SORTMERNA_DB/silva-euk-18s-id95.fasta \
-ref $SORTMERNA_DB/silva-euk-28s-id98.fasta \
-reads $file --aligned $RIBOSOMAL_FILES/$file.ribosomes --other $RIBODEPLETED_FILES/$shortname --fastx --threads 14 -v
rm -r $HOME/sortmerna
done


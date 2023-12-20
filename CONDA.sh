
cd 

#create conda environment
conda create --name metatrans python=3.6
#activate
conda activate metatrans
#verify python version
python --version
#Then perform a one-time set up of Bioconda with the following commands. This will modify your ~/.condarc file:

conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda config --set channel_priority strict

#then install packages required using conda install
conda install -c bioconda pear
conda install -c bioconda trimmomatic
conda install -c bioconda diamond
conda install -c bioconda sortmerna


#create directories
mkdir metatranscriptomics
META=$HOME/metatranscriptomics

mkdir databases
DATABASES="$META/databases"
SORTMERNA_DB="$DATABASES/rRNA_database"
mkdir $META/02_assembled-reads
mkdir $META/03_ribodepleted-reads
mkdir $META/03.1_rrna-reads
MERGED_FILES="$META/02_assembled-reads"
RIBODEPLETED_FILES="$META/03_ribodepleted-reads"
RIBOSOMAL_FILES="$META/03.1_rrna-reads"
mkdir $DATABASES/hg37-human-db
HUMAN_DB="$DATABASES/hg37-human-db"

#download batabases for sortmerna
cd $SORTMERNA_DB
nano downloaddb.sh 
#paste this:

#!/bin/bash
wget https://raw.githubusercontent.com/PalomaresScorp28/sortmerna/master/data/rRNA_databases/silva-arc-23s-id98.fasta
wget https://raw.githubusercontent.com/PalomaresScorp28/sortmerna/master/data/rRNA_databases/silva-arc-16s-id95.fasta
wget https://raw.githubusercontent.com/PalomaresScorp28/sortmerna/master/data/rRNA_databases/silva-bac-16s-id90.fasta
wget https://raw.githubusercontent.com/PalomaresScorp28/sortmerna/master/data/rRNA_databases/silva-bac-23s-id98.fasta
wget https://raw.githubusercontent.com/PalomaresScorp28/sortmerna/master/data/rRNA_databases/silva-euk-18s-id95.fasta
wget https://raw.githubusercontent.com/PalomaresScorp28/sortmerna/master/data/rRNA_databases/silva-euk-28s-id98.fasta
wget https://github.com/PalomaresScorp28/sortmerna/blob/master/data/rRNA_databases/silva_ids_acc_tax.tar.gz
wget https://raw.githubusercontent.com/PalomaresScorp28/sortmerna/master/data/rRNA_databases/rfam-5.8s-database-id98.fasta
wget https://raw.githubusercontent.com/PalomaresScorp28/sortmerna/master/data/rRNA_databases/rfam-5s-database-id98.fasta

#end

rm downloaddb.sh 
cd 
conda install -c bioconda kneaddata

#Download human transcriptome (hg38) reference database (approx. size = 254 MB).

kneaddata_database --download human_transcriptome bowtie2 $HUMAN_DB
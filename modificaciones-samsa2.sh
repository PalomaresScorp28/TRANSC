
#Setting up databases for sortmerna

#indexes

./indexdb_rna --ref ./rRNA_databases/silva-bac-16s-id90.fasta,./index/silva-bac-16s-db:\
./rRNA_databases/silva-bac-23s-id98.fasta,./index/silva-bac-23s-db:\
./rRNA_databases/silva-arc-16s-id95.fasta,./index/silva-arc-16s-db:\
./rRNA_databases/silva-arc-23s-id98.fasta,./index/silva-arc-23s-db:\
./rRNA_databases/silva-euk-18s-id95.fasta,./index/silva-euk-18s-db:\
./rRNA_databases/silva-euk-28s-id98.fasta,./index/silva-euk-28s:\
./rRNA_databases/rfam-5s-database-id98.fasta,./index/rfam-5s-db:\
./rRNA_databases/rfam-5.8s-database-id98.fasta,./index/rfam-5.8s-db

#or 

./indexdb_rna --ref ./rRNA_databases/silva-bac-16s-id90.fasta,./index/silva-bac-16s-db -v
./indexdb_rna --ref ./rRNA_databases/silva-bac-23s-id98.fasta,./index/silva-bac-23s-db -v
./indexdb_rna --ref ./rRNA_databases/silva-arc-16s-id95.fasta,./index/silva-arc-16s-db -v
./indexdb_rna --ref ./rRNA_databases/silva-arc-23s-id98.fasta,./index/silva-arc-23s-db -v
./indexdb_rna --ref ./rRNA_databases/silva-euk-18s-id95.fasta,./index/silva-euk-18s-db -v
./indexdb_rna --ref ./rRNA_databases/silva-euk-28s-id98.fasta,./index/silva-euk-28s -v
./indexdb_rna --ref ./rRNA_databases/rfam-5s-database-id98.fasta,./index/rfam-5s-db -v
./indexdb_rna --ref ./rRNA_databases/rfam-5.8s-database-id98.fasta,./index/rfam-5.8s-db -v

## correr sortme con nuevos indices

for file in $STEP_2/*.assembled2.fastq
do
  shortname=`echo $file | awk -F "assembled2" '{print $1 "ribodepleted"}'`
  checked $SORTMERNA -a $threads \
    --ref $SORTMERNA_DIR/rRNA_databases/silva-bac-16s-id90.fasta,$SORTMERNA_DIR/index/silva-bac-16s-db:\
    $SORTMERNA_DIR/rRNA_databases/silva-bac-23s-id98.fasta,$SORTMERNA_DIR/index/silva-bac-23s-db:\
    $SORTMERNA_DIR/rRNA_databases/silva-arc-16s-id95.fasta,$SORTMERNA_DIR/index/silva-arc-16s-db:\
    $SORTMERNA_DIR/rRNA_databases/silva-arc-23s-id98.fasta,$SORTMERNA_DIR/index/silva-arc-23s-db:\
    $SORTMERNA_DIR/rRNA_databases/silva-euk-18s-id95.fasta,$SORTMERNA_DIR/index/silva-euk-18s-db:\
    $SORTMERNA_DIR/rRNA_databases/silva-euk-28s-id98.fasta,$SORTMERNA_DIR/index/silva-euk-28s:\
    $SORTMERNA_DIR/rRNA_databases/rfam-5s-database-id98.fasta,$SORTMERNA_DIR/index/rfam-5s-db:\
    $SORTMERNA_DIR/rRNA_databases/rfam-5.8s-database-id98.fasta,$SORTMERNA_DIR/index/rfam-5.8s-db\
 --reads $file --aligned $file.ribosomes --other $shortname --fastx \
 --log -v
done




#######################################################################
# Download CAZY database:

echo "NOW DOWNLOADING CAZY DATABASE AT: "; date 
wget -r -np -R "index.html*" https://bcb.unl.edu/dbCAN2/download/ --no-check-certificate



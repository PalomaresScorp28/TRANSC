
cd
mkdir step_2_output
mkdir step_3_output
mkdir sortme-ribosomes

scp virginia.rodriguez@148.247.66.150:/home/virginia.rodriguez/apps/samsa2/step_2_output/*merged.assembled2.fastq /home/pscorp28/step_2_output


SORTMERNA_DB=/home/pscorp28/rRNA_database
MERGED_FILES=/home/pscorp28/step_2_output
RIBODEPLETED_FILES=/home/pscorp28/step_3_output
RIBOSOMAL_FILES=/home/pscorp28/sortme-ribosomes
# $SORTMERNA_DB
# $MERGED_FILES


sortmerna -ref $SORTMERNA_DB/rfam-5.8s-database-id98.fasta\
 -ref $SORTMERNA_DB/rfam-5s-database-id98.fasta\
 -ref $SORTMERNA_DB/silva-arc-16s-id95.fasta\
 -ref $SORTMERNA_DB/silva-arc-23s-id98.fasta\
 -ref $SORTMERNA_DB/silva-bac-16s-id90.fasta\
 -ref $SORTMERNA_DB/silva-bac-23s-id98.fasta\
 -ref $SORTMERNA_DB/silva-euk-18s-id95.fasta\
 -ref $SORTMERNA_DB/silva-euk-28s-id98.fasta\
 -reads $MERGED_FILES/test_read.fasta -aligned test.ribosomes --other test.ribodepleted --fastx -v 

for file in $MERGED_FILES/*.assembled2.fastq
do
shortname=`echo $file | awk -F "assembled2" '{print $1 "ribodepleted"}'`
sortmerna -ref $SORTMERNA_DB/rfam-5.8s-database-id98.fasta \
-ref $SORTMERNA_DB/rfam-5s-database-id98.fasta \
-ref $SORTMERNA_DB/silva-arc-16s-id95.fasta \
-ref $SORTMERNA_DB/silva-arc-23s-id98.fasta \
-ref $SORTMERNA_DB/silva-bac-16s-id90.fasta \
-ref $SORTMERNA_DB/silva-bac-23s-id98.fasta \
-ref $SORTMERNA_DB/silva-euk-18s-id95.fasta \
-ref $SORTMERNA_DB/silva-euk-28s-id98.fasta \
-reads $file --aligned $file.ribosomes --other $shortname --fastx --threads 12 -v
done

cd

mv *ribodepleted* $RIBODEPLETED_FILES/
mv *ribosomes* $RIBOSOMAL_FILES/


    #!/bin/bash

    #Let us do a very simple two step approach (@Pierre has a fancier one liner).

    #Step 1: Grab the unique sample ID's in a file


    #Los usos básicos que podemos dar al comando Awk son los siguientes:
    #Buscar palabras y patrones de palabras y reemplazarlos por otras palabras y/o patrones.
    #Hacer operaciones matemáticas.
    #Procesar texto y mostrar las líneas y columnas que cumplen con determinadas condiciones.
    #Etc.


    #mis archivos se ven así

    #LANE 1:4 R1
    #RL725-mf_S11_L004_R1_001.fastq
    #RL725-mf_S11_L004_R1_002.fastq
    #RL725-mf_S11_L004_R1_003.fastq
    #RL725-mf_S11_L004_R1_004.fastq

    #LANE 1:4 R2
    #RL725-mf_S11_L004_R2_001.fastq
    #RL725-mf_S11_L004_R2_002.fastq
    #RL725-mf_S11_L004_R2_003.fastq
    #RL725-mf_S11_L004_R2_004.fastq


    #ls -1 # mostrar una sola columna 
    #ls -1 *R1*.fastq # mostrar una sola columna solo lo que es *R1*.fastq
    #ls -1 *R1*.fastq | awk -F '_'  #con separador
    #ls -1 *R1*.fastq | awk -F '_L' '{print $1}' # primera columa dada por separador "_L"
    
    
    ls -1 *R1*.fastq | awk -F '_L' '{print $1}' | sed -r 's/["./]+//g'| sort | uniq > ID #ORDENAR SIN REPETIR Y GUARDAR EN ARCHIVO "ID"


    #for i in `cat ./ID`;  do echo cat $i"_L001_R1_001.fastq"/ $i"_L002_R1_001.fastq"/  $i"_L003_R1_001.fastq"/ $i"_L004_R1_001.fastq"/ > $i\_R1.fastq; done

    #Eliminar el echo cuando este for funcione y agregar el R2

    for i in `cat ./ID`;\
    do cat $i"_L001_R1_001.fastq" $i"_L002_R1_001.fastq" $i"_L003_R1_001.fastq" $i"_L004_R1_001.fastq" > $i\_R1.fastq;\
        cat $i"_L001_R2_001.fastq" $i"_L002_R2_001.fastq" $i"_L003_R2_001.fastq" $i"_L004_R2_001.fastq" > $i\_R2.fastq;\ 
    done


########################################


#Voy a copiar una muestra real de prueba:
#ls -1 ../canizales-samsa2/input_files/ | sort | head -8 > RL509
#for i in `cat ./RL509`; do cp ../canizales-samsa2/input_files/$i .; done #CUANDO HICE ESTO DESCUBRÍ QUE LAS SECUENCIAS NO TENIAN UN R1 O R2 DE ALGÚN LANE
#.....
#ME PUSE A VERIFICAR QUE PUEDA HACER UN MERGE

#Archivos con secuencias R1 Y R2 (LISTAS)
ls -1 | find -name "*R2_001.fastq" | awk -F '_R' '{print $1}'| sort  > R2.fastq
ls -1 | find -name "*R1_001.fastq" | awk -F '_R' '{print $1}'| sort  > R1.fastq


diff -q R2.fastq R1.fastq  ### COMPARO 
#Files R2.fastq and R1.fastq differ

diff -y -W 50 --suppress-common-lines R2.fastq R1.fastq  ### COMPARO #comparacion izq-der

diff -u R2.fastq R1.fastq  ### COMPARO 

diff -u R1.fastq R2.fastq | grep -- '-./R*' > dismatch1
diff -u R1.fastq R2.fastq | grep -- '+./R*' > dismatch2

cat dismatch1 dismatch2 | sed -r 's/['-'+./]+//g' 
paste dismatch1 dismatch2 | sed -r 's/['-'+./]+//g' > dismatch-R1-R2.tsv

sed  -i '1i huerfanasR1 huerfanasR2' dismatch-R1-R2.tsv


#Archivos con secuencias R1 L001 a L004 (LISTAS)
ls -1 | find -name "*L001_R1_001.fastq" | awk -F '_L' '{print $1}' | sed -r 's/["./]+//g'| sort  > L1.R1.fastq
ls -1 | find -name "*L002_R1_001.fastq" | awk -F '_L' '{print $1}' | sed -r 's/["./]+//g'| sort  > L2.R1.fastq
ls -1 | find -name "*L003_R1_001.fastq" | awk -F '_L' '{print $1}' | sed -r 's/["./]+//g'| sort  > L3.R1.fastq
ls -1 | find -name "*L004_R1_001.fastq" | awk -F '_L' '{print $1}' | sed -r 's/["./]+//g'| sort  > L4.R1.fastq
#Archivos con secuencias R2 L001 a L004 (LISTAS)
ls -1 | find -name "*L001_R2_001.fastq" | awk -F '_L' '{print $1}' | sed -r 's/["./]+//g'| sort  > L1.R2.fastq
ls -1 | find -name "*L002_R2_001.fastq" | awk -F '_L' '{print $1}' | sed -r 's/["./]+//g'| sort  > L2.R2.fastq
ls -1 | find -name "*L003_R2_001.fastq" | awk -F '_L' '{print $1}' | sed -r 's/["./]+//g'| sort  > L3.R2.fastq
ls -1 | find -name "*L004_R2_001.fastq" | awk -F '_L' '{print $1}' | sed -r 's/["./]+//g'| sort  > L4.R2.fastq

###PARA VER TODAS MIS SECUENCIAS POR LANE Y R1 O R2
paste L1.R1.fastq L2.R1.fastq L3.R1.fastq L4.R1.fastq L1.R2.fastq L2.R2.fastq L3.R2.fastq L4.R2.fastq >> registros-seqs.tsv

# PARA PONER COLUMNA CON TÍTULO
sed  -i '1i Lane1.R1 Lane2.R1 Lane3.R1 Lane4.R1 Lane1.R2 Lane2.R2 Lane3.R2 Lane4.R2' registros-seqs.tsv 


 
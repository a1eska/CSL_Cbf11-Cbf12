#!/bin/bash

# Cbf11, Cbf12
#
for dir in ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR713/ERR713{576..593}; do
    wget "$dir/*.gz"
done

# https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE130846
# Loz1
#
for ((i=3; i<9; i++)); do
  for dir in ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR902/00$i/SRR902444$i; do
      wget "$dir/*.gz"
  done
done


# https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA509382&o=acc_s%3Aa
# Tup11, Src1, Rst2

for ((i=5; i<10; i++)); do
  for dir in ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR831/00$i/SRR831118$i; do
      wget "$dir/*.gz"
  done
done

for ((i=0; i<10; i++)); do
  for dir in ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR831/00$i/SRR831119$i; do
      wget "$dir/*.gz"
  done

  for dir in ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR831/00$i/SRR831120$i; do
      wget "$dir/*.gz"
  done
done

for ((i=0; i<4; i++)); do
  for dir in ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR831/00$i/SRR831121$i; do
      wget "$dir/*.gz"
  done
done

# https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA259353&o=acc_s%3Aa
# Sak1

for ((i=8; i<10; i++)); do
  for dir in ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR155/00$i/SRR155693$i; do
      wget "$dir/*.gz"
  done
done

for ((i=0; i<6; i++)); do
  for dir in ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR155/00$i/SRR155694$i; do
      wget "$dir/*.gz"
  done
done
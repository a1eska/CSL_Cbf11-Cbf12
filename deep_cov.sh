#!/bin/bash


# DeepTools bamCoverage
# generates BIGWIG coverage track from BAM files
# --binSize 1 : set  bin size to 1 for BIDWIG files
# 
for i in $(ls rev/ | cut -d "." -f1); do
  bamCoverage --binSize 1  -b fw/*$i*.bam  -o $i.fwd.bw
done

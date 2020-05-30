#!/bin/bash


# DeepTools bamCoverage
# generates BIGWIG coverage track from BAM files
# --binSize 1 : set  bin size to 1 for BIDWIG files
# 
OUTDIR="bigwig"
RMDUP=$OUTDIR/"rmdup"
DUPLICATE=$OUTDIR/"dup"
REVERSE=$OUTDIR/"rw"
FORWARD=$OUTDIR/"fwd"

mkdir -p $RMDUP
mkdir -p $DUPLICATE
mkdir -p $REVERSE
mkdir -p $FORWARD

SAMPLEDIR="$(pwd)/$1"

for BAM in $(ls $SAMPLEDIR | grep -v '.bai' | grep '.bam'); do
        bamCoverage --binSize 1 --effectiveGenomeSize 12631379 --minMappingQuality 60 --centerReads -b $SAMPLEDIR/$BAM  -o $RMDUP/$BAM.bw
        bamCoverage --binSize 1 --effectiveGenomeSize 12631379 --centerReads -b $SAMPLEDIR/$BAM  -o $DUPLICATE/$BAM.bw
        bamCoverage --binSize 1 --effectiveGenomeSize 12631379 --minMappingQuality 60 --samFlagInclude 16 --centerReads -b $SAMPLEDIR/$BAM  -o $REVERSE/$BAM.bw
        bamCoverage --binSize 1 --effectiveGenomeSize 12631379 --minMappingQuality 60 --samFlagExclude 16 --centerReads -b $SAMPLEDIR/$BAM  -o $FORWARD/$BAM.bw
done

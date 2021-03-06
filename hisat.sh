#!/bin/bash

# Usage:
# $ ./hisat [-s] -in <sample/directory>
#     -s  for single-end reads

# Hisat2 common options
HISAT="-x $(pwd)/genome/pombe -k 30  --no-spliced-alignment "

# Define project (current) diirectory
SAMPLEDIR=$(pwd)
OUTDIR="out"

# Initialize variable for single/paired end samples
single=0


# Get argument tokens
for arg in "$@"; do
    case $arg in
        -s)
            single=1
            shift
            ;;
        -in)
            SAMPLEDIR=$SAMPLEDIR/$2
            OUTDIR=$OUTDIR/$2
            shift 2
            ;;
        *)
            ;;
    esac
done


# Make output directory
mkdir -p $OUTDIR


# Print list of samples of interest
echo "...List of samples..."
ls $SAMPLEDIR


# Unzip file (for MAC)
# Comment if needed
echo "...unziping files..."
for SAMPLE in $(ls $SAMPLEDIR/*.gz); do
    gunzip $SAMPLE
done
echo "Done."


# Hisat alignment
# 
echo "...mapping with HISAT2..."
if [ $single -eq 1 ];
then 
    for SAMPLE in $(ls $SAMPLEDIR); do
        hisat2-align-s $HISAT -U  $SAMPLEDIR/$SAMPLE  --summary-file $OUTDIR/$SAMPLE.txt | tee >(samtools flagstat - > $OUTDIR/$SAMPLE.flagstat) | samtools sort -O BAM | tee $OUTDIR/$SAMPLE.bam | samtools index - $OUTDIR/$SAMPLE.bam.bai
    done
else
    for SAMPLE in $(ls $SAMPLEDIR | cut -d "_" -f1); do
        hisat2-align-s $HISAT -1 $SAMPLEDIR/$SAMPLE*1* -2 $SAMPLEDIR/$SAMPLE*2* --summary-file $OUTDIR/$SAMPLE.txt | tee >(samtools flagstat - > $OUTDIR/$SAMPLE.flagstat) | samtools sort -O BAM | tee $OUTDIR/$SAMPLE.bam | samtools index - $OUTDIR/$SAMPLE.bam.bai
    done
fi
echo "Done."


# Merge output statistics
#
echo "...prepearing output statistics..."
for stats in $(ls $OUTDIR/*.txt); do
    echo Filename : "$stats" ; echo ; cat "$stats" ; echo ;
done > $OUTDIR/hisat_alignment_statistics

rm $OUTDIR/*.txt

# Merge output flagstats
#
echo "...prepearing output flagstats..."
for stats in $(ls $OUTDIR/*.flagstat); do
    echo Filename : "$stats" ; echo ; cat "$stats" ; echo ;
done > $OUTDIR/samtools_flagstats

rm $OUTDIR/*.flagstat

# QC
#
echo "...start QC of BAMs..."
fastqc $OUTDIR/*bam
multiqc $OUTDIR -o $OUTDIR
mv $OUTDIR/*fastqc* $OUTDIR/multiqc_data/
echo "Done."

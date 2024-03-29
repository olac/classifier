#!/bin/bash

# classify.sh
# Aug 28, 2009
# Joshua S Hou
# mod by Sven Pedersen for Classification "server"
# 
# Test stage of resource type classifier
# 
# Usage: ./classify.sh input-document output

EXPECTED_ARGS=3
E_BADARGS=65
if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Usage: `basename $0` classifier input-document output"
    echo "  classifier: binary or multi"
    echo "  input-document must be in plaintext format:"
    echo "  [name]\t[label]\t[data]"
    exit $E_BADARGS
fi

DIRECTORY=$1
input_file=$2
output_file=$3
process="./$DIRECTORY/MalletClassifierInputFile.tmp"
output="./$DIRECTORY/MalletClassifierOutputFile.tmp"

echo "Classifying..."
# remove old data lying around
if [ -f $output ]
then
    echo "  Deleting old process file"
    rm -f $output
fi

# create link to process input file
if [ -f $process ]
then
    echo "  Deleting old input file"
    rm -f $process
fi
ln $input_file $process

# loop until the output file appears
until [ -f $output ]; do
	sleep 6
done

# remove old data lying around
if [ -f $output_file ]
then
    rm -f $output_file
fi
# create link to access output file
ln $output $output_file
echo "Finished."


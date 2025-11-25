#!/bin/bash

tar -zxf tcga_data.tar.gz -k

echo "Condition,Value" > data.csv
GENE="NKX2-1"

cat gdc_sample_sheet.tsv | while IFS=$'\t' read id filename cat data_type project case_id sample_id type rest
do
    
    if [ "$id" == "File ID" ]; then
        continue
    fi


    if [ "$type" == "Primary Tumor" ] || [ "$type" == "Solid Tissue Normal" ]; then
        
        filepath="$id/$filename"
        
        if [ -f "$filepath" ]; then
            tpm=$(grep "$GENE" "$filepath" | cut -f7)
            echo "$type,$tpm" >> data.csv
        fi
    fi
done

echo "Check data.csv now."

#!/bin/bash

tar -zxf tcga_data.tar.gz


echo "Condition,Value" > data.csv   #changed the column names to be simpler

GENE="NKX2-1"

cat gdc_sample_sheet.tsv | while IFS=$'\t' read id filename project sample_id type rest
do
    
    if [ "$id" == "File ID" ]; then   # Removing header
        continue
    fi

   
    if [ "$type" == "Primary Tumor" ] || [ "$type" == "Solid Tissue Normal" ]; then
        
        filepath="$id/$filename"
        
        
        if [ -f "$filepath" ]; then
            
            tpm=$(grep "$GENE" "$filepath" | cut -f7)      # 'cut -f7' takes the 7th tab-separated column (tpm_unstranded)
            
            echo "$type,$tpm" >> data.csv
        fi
    fi
done

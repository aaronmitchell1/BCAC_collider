#keep only the OncoArray related columns otherwise the file is very large 5GB, including iCOGS results seems to cause issues with RSIDs etc.

input_file="icogs_onco_gwas_meta_overall_breast_cancer_summary_level_statistics.txt"
output_file="output_file.txt"
columns="SNP.Onco chr.Onco Position.Onco beta.Onco SE.Onco Effect.Gwas Baseline.Gwas Freq.Gwas"

awk -v OFS='\t' -v cols="$columns" '
    BEGIN {
        n = split(cols, col_array, " ")
        for (i=1; i<=n; i++) {
            col_index[col_array[i]] = i
        }
    }
    {
        for (i=1; i<=n; i++) {
            printf "%s\t", $col_index[col_array[i]]
        }
        printf "\n"
    }
' "$input_file" > "$output_file"

echo "Extracted columns saved to: $output_file"

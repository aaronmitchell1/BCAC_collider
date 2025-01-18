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
    NR==1 { 
        for (i=1; i<=NF; i++) {
            header[i] = $i 
        }
        for (i=1; i<=n; i++) {
            for (j=1; j<=NF; j++) {
                if (header[j] == col_array[i]) {
                    printf "%s\t", header[j] 
                    break 
                }
            }
        }
        printf "\n" 
    }
    NR>1 { 
        for (i=1; i<=n; i++) {
            for (j=1; j<=NF; j++) {
                if (header[j] == col_array[i]) {
                    printf "%s\t", $j 
                    break 
                }
            }
        }
        printf "\n"
    }
' "$input_file" > "$output_file"

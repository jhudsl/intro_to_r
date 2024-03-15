#!/usr/bin/env bash

find modules/ -type f -name "*_Key.Rmd" -print0 | while IFS= read -r -d '' file; do
    # Remove Rmarkdown chunk content
    # !! Note that the chunks must be named, with the name ending with "response" 
    # to be cleared. This prevents unwanted erasure of library loading and knitr
    # options. EG, a chunk set to be cleared would look like:
    #```{r 1.1response}
    #my.num <- c(5, 4, 7, 8, 12, 14) # These can be any real numbers
    #```
    modified_file="${file%_Key.Rmd}.Rmd"
    awk 'BEGIN {RS="```"} NR%2==0 {gsub("response}.*", "response}\n\n")} {gsub("response\047}.*", "response\047}\n\n")} NR>1 {printf "%s%s", prev_record, RS} {prev_record=$0} END {printf "%s", prev_record}' "$file" > "$modified_file"
    echo created $modified_file

    # Remove " - Key" from YAML header
    # requires a backup which is then deleted
    sed -i'' -e '/^title:/ s/ - Key//' "$modified_file"
    rm -f "${modified_file}-e"
done

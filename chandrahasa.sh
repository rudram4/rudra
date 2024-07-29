#!/bin/bash

while getopts ":t:l:d:h" opt; do
    case $opt in
        t)
            IFS=',' read -ra domains <<< "$OPTARG"
            ;;
        l)
            if [ -r "$OPTARG" ]; then
                mapfile -t domains < "$OPTARG"
            else
                echo "Error: Unable to read domain list file '$OPTARG'."
                exit 1
            fi
            ;;
        d)
            output_directory="$OPTARG"
            ;;
        h)
            echo "Usage: ./chandrahasa.sh [-t domain1,domain2,... | -l domain_list_file] -d output_directory"
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            exit 1
            ;;
    esac
done

if [ "${#domains[@]}" -eq 0 ]; then
    echo "Error: No domains provided."
    exit 1
fi

if [ -z "$output_directory" ]; then
    echo "Error: Output directory not specified."
    exit 1
fi

mkdir -p "$output_directory"

for domain in "${domains[@]}"; do
    echo -e "Processing domain: $domain"

    # Subdomain Enumeration
    ./subdomainer -t "$domain" -f true

    # Change to the domain directory
    mv "$domain" "$output_directory"

    echo -e "Completed processing domain: $domain"
    echo "----------------------------------"
done

cd "$output_directory"

# Collect all all-live.txt files from domain directories and combine them into one file
find . -mindepth 2 -type f -name "all-live.txt" -exec sh -c 'cat {} >> combined-all-live.txt' \;

# Nuclei Scanning on collected-all-live.txt
nuclei -l combined-all-live.txt -es info -o nucleiall.txt

cd ..

echo "All results collected in '$output_directory'."

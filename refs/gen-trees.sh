#!/bin/bash

echo "Generating tree diagrams..."

pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings ../ietf-crypto-types@*.yang > ietf-crypto-types-tree.txt
pyang -p ../ -f tree --tree-line-length 69 ../ex-crypto-types-usage@*.yang > ex-crypto-types-usage-tree.txt


extract_grouping_with_params() {
  # $1 name of grouping
  # $2 addition CLI params
  # $3 output filename
  pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings $2 ../ietf-crypto-types@*.yang > ex-crypto-types-groupings-tree.txt
  cat ex-crypto-types-groupings-tree.txt | sed -n "/^  grouping $1/,/^  grouping/p" > tmp 
  c=$(grep -c "^  grouping" tmp)
  if [ "$c" -ne "1" ]; then
    ghead -n -1 tmp > $3
    rm tmp
  else
    mv tmp $3
  fi
}

extract_grouping() {
  # $1 name of grouping
  extract_grouping_with_params "$1" "" "tree-$1.expanded.txt"
  extract_grouping_with_params "$1" "--tree-no-expand-uses" "tree-$1.no-expand.txt"
}

extract_grouping encrypted-value-grouping
extract_grouping password-grouping
extract_grouping symmetric-key-grouping
extract_grouping public-key-grouping
extract_grouping private-key-grouping
extract_grouping asymmetric-key-pair-grouping
extract_grouping certificate-expiration-grouping
extract_grouping trust-anchor-cert-grouping
extract_grouping end-entity-cert-grouping
extract_grouping generate-csr-grouping
extract_grouping asymmetric-key-pair-with-cert-grouping
extract_grouping asymmetric-key-pair-with-certs-grouping


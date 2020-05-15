#!/bin/bash

run_unix_cmd() {
  # $1 is the line number
  # $2 is the cmd to run
  # $3 is the expected exit code
  output=`$2 2>&1`
  exit_code=$?
  if [[ $exit_code -ne $3 ]]; then
    printf "failed (incorrect exit status code) on line $1.\n"
    printf "  - exit code: $exit_code (expected $3)\n"
    printf "  - command: $2\n"
    if [[ -z $output ]]; then
      printf "  - output: <none>\n\n"
    else
      printf "  - output: <starts on next line>\n$output\n\n"
    fi
    exit 1
  fi
}

printf "Testing ietf-crypto-types.yang (pyang)..."
command="pyang -Werror --canonical --ietf --max-line-length=69 -p ../ ../ietf-crypto-types\@20*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-crypto-types.yang (yanglint)..."
command="yanglint ../ietf-crypto-types\@20*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing iana-symmetric-algs.yang (pyang)..."
command="pyang -Werror --canonical --ietf --max-line-length=69 -p ../ ../iana-symmetric-algs\@20*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing iana-symmetric-algs.yang (yanglint)..."
command="yanglint ../iana-symmetric-algs\@20*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing iana-asymmetric-algs.yang (pyang)..."
command="pyang -Werror --canonical --ietf --max-line-length=69 -p ../ ../iana-asymmetric-algs\@20*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing iana-asymmetric-algs.yang (yanglint)..."
command="yanglint ../iana-asymmetric-algs\@20*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing iana-hash-algs.yang (pyang)..."
command="pyang -Werror --canonical --ietf --max-line-length=69 -p ../ ../iana-hash-algs\@20*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing iana-hash-algs.yang (yanglint)..."
command="yanglint ../iana-hash-algs\@20*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ex-crypto-types-usage.yang (pyang)..."
command="pyang -Werror --lint --max-line-length=69 -p ../ ../ex-crypto-types-usage.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ex-crypto-types-usage.yang (yanglint)..."
command="yanglint ../ex-crypto-types-usage.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"



printf "Testing ex-crypto-types-usage.xml..."
command="yanglint -m -t config -s ../ex-crypto-types-usage.yang ../ietf-crypto-types\@20*.yang ./ietf-origin.yang  ex-crypto-types-usage.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

#printf "Testing ex-generate-symmetric-key-rpc.xml..."
#command="yanglint -s -t auto ../ietf-*\@*.yang ex-generate-symmetric-key-rpc.xml"
#run_unix_cmd $LINENO "$command" 0
#printf "okay.\n"

#printf "Testing ex-generate-symmetric-key-rpc-reply.xml..."
#command="yanglint -s -t auto ../ietf-*\@*.yang ex-generate-symmetric-key-rpc-reply.xml ex-generate-symmetric-key-rpc.xml"
#run_unix_cmd $LINENO "$command" 0
#printf "okay.\n"

#printf "Testing ex-generate-asymmetric-key-rpc.xml..."
#command="yanglint -s -t auto ../ietf-*\@*.yang ex-generate-asymmetric-key-rpc.xml"
#run_unix_cmd $LINENO "$command" 0
#printf "okay.\n"

#printf "Testing ex-generate-asymmetric-key-rpc-reply.xml..."
#command="yanglint -s -t auto ../ietf-*\@*.yang ex-generate-asymmetric-key-rpc-reply.xml ex-generate-asymmetric-key-rpc.xml"
#run_unix_cmd $LINENO "$command" 0
#printf "okay.\n"

printf "Testing ex-crypto-types-gcsr-rpc.xml..."
command="yanglint -s -t auto ../ex-crypto-types-usage.yang ex-crypto-types-gcsr-rpc.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ex-crypto-types-gcsr-rpc-reply.xml..."
command="yanglint -s -t auto ../ex-crypto-types-usage.yang ex-crypto-types-gcsr-rpc-reply.xml ex-crypto-types-gcsr-rpc.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ex-crypto-types-ce-notification.xml..."
echo -e 'setns a=urn:ietf:params:xml:ns:neteonf:notification:1.0\nsetns b=urn:ietf:params:xml:ns:yang:ietf-crypto-types\ncat //a:notification/b:crypto-types' | xmllint --shell ex-crypto-types-ce-notification.xml | sed -e '/^\/.*/d' -e '/^ *$/d' > yanglint-notification.xml
command="yanglint -s -t notif -r ex-crypto-types-usage.xml ../ex-crypto-types-usage.yang  ../ietf-crypto-types\@20*.yang yanglint-notification.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"
rm yanglint-notification.xml



#printf "Testing ex-symmetric-algs.xml..."
#command="yanglint -m -t data -s ../iana-symmetric-algs\@20*.yang ./ietf-origin.yang ex-symmetric-algs.xml"
#run_unix_cmd $LINENO "$command" 0
#printf "okay.\n"
#
#printf "Testing ex-asymmetric-algs.xml..."
#command="yanglint -m -t data -s ../iana-asymmetric-algs\@20*.yang ./ietf-origin.yang ex-asymmetric-algs.xml"
#run_unix_cmd $LINENO "$command" 0
#printf "okay.\n"
#
#printf "Testing ex-hash-algs.xml..."
#command="yanglint -m -t data -s ../iana-hash-algs\@20*.yang ./ietf-origin.yang ex-hash-algs.xml"
#run_unix_cmd $LINENO "$command" 0
#printf "okay.\n"

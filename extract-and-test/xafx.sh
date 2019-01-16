#!/bin/bash

# globals
debug=0
infile=""
FOLD=/Users/kwatsen/Juniper/version-control-servers/github/netmod-wg/artwork-folding/fold-artwork.sh


print_usage() {
  echo
  echo "Extracts <artwork> elements having the \"name\" attribute"
  echo "set from the specified XML-based IETF draft.  If a \"CDATA\""
  echo "escape is found, it is removed.  If folded, it is unfolded."
  echo
  echo "Usage: $0 <outfile>"
  echo
  echo "  -i: the input filename"
  echo "  -d: show debug messages"
  echo "  -h: show this message"
  echo
  echo "Exit status code: zero on success, non-zero otherwise."
  echo
}

process_input() {
  while [ "$1" != "" ]; do
    if [ "$1" == "-h" -o "$1" == "--help" ]; then
      print_usage
      exit 1
    fi
    if [ "$1" == "-d" ]; then
      debug=1
    fi
    if [ "$1" == "-i" ]; then
      infile="$2"
      shift
    fi
    shift 
  done

  if [ -z "$infile" ]; then
    echo
    echo "Error: infile parameter missing (use -h for help)"
    echo
    exit 1
  fi

  if [ ! -f "$infile" ]; then
    echo
    echo "Error: specified file \"$infile\" is does not exist."
    echo
    exit 1
  fi
}

extract_artwork() {
  #files=`grep "artwork name=" $infile | sed 's/.*name="\(.*\)".*/\1/'`
  files=`grep "artwork" $infile | grep "name=" | sed 's/.*name="\(.*\)".*/\1/'`

  for file in $files; do

    if [[ $debug -eq 1 ]]; then
      echo "extracting $file..."
    fi

    echo -e 'cat //*[@name="'$file'"]/text()' | xmllint --shell $infile | egrep -v '^(/ >| -----)' > $file

    grep "CDATA" $file > /dev/null
    if [[ $? -eq 0 ]]; then
      if [[ $debug -eq 1 ]]; then
        echo "  ^ removing CDATA..."
      fi
      mv $file tmp
      cat tmp | sed '/<!\[CDATA\[/,/]]>/!d;//d' > $file
      rm tmp
    fi

    # Source XML files SHOULD NOT contain folded lines. Instead,
    # `xml2rfc` SHOULD be updated to itself fold lines when needed.
    #
    # Authors MAY put folded artwork in XML files while waiting
    # for `xml2rfc` to be updated.  The following is to support
    # cases where this occurs.
    grep "line wrapping per BCP XX (RFC XXXX)" $file > /dev/null
    if [[ $? -eq 0 ]]; then
      if [[ $debug -eq 1 ]]; then
        echo "  ^ unfolding..."
      fi
      mv $file tmp
      if [[ $debug -eq 1 ]]; then
        $FOLD -r -i tmp -o $file -d
      else
        $FOLD -r -i tmp -o $file
      fi
      rm tmp
    fi

  done
}

main() {
  if [ "$#" == "0" ]; then
     print_usage
     exit 1
  fi
  process_input $@
  extract_artwork
  code=$?
  exit $code
}

main "$@"


#!/bin/bash

pv hybrid-analysis.txt \
    | parallel --pipe -l 20000 -P 1 lynx -dump -stdin -nolist -width 1024 2> /dev/null \
    | grep -Pi '^...[a-f0-9]{64}' \
    > results.txt

awk '{print "[\""$1 "\",\"" $2 " " $3 " " $4"\"]"}' results.txt \
    | sed 's/  //' \
    | sed 's/ "/"/' \
    | jq -c '[{index:{_id:(.[0]+.[1]),_index:"ha",_type:"ha"}},{sha256:.[0],result:.[1]}] | .[]' \
    | parallel --pipe -l 50000 -P 1 'curl http://localhost:9200/_bulk -u elastic:changeme -H content-type:application/x-ndjson --data-binary @- -s --compressed > /dev/null && echo -n .' \
    2> /dev/null

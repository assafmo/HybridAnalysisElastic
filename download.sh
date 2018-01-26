#!/bin/bash

seq 1 10700 \
	| parallel --bar -P 8 'curl https://www.hybrid-analysis.com/recent-submissions -G -d filter=file --data-urlencode sort=^timestamp -d page={} -H "user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36" --compressed -s' \
	>> hybrid-analysis.txt

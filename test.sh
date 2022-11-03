#!/bin/bash
#set -euxo pipefail
set -euo pipefail

# do 10 requests with one header and printout which instance replied
for i in {1..10}
do
  curl -s -X POST --header "Authorization: Bearer syt_UsernameB64_rndBase64_chksumB64" 'http://localhost:8080/' |grep 'Hostname'
done

#!/bin/bash
#set -euxo pipefail
set -euo pipefail

# do 10 requests with one header and printout which instance replied
for i in {1..10}
do
  curl -s -X POST --header "Authorization: Bearer syt_UsernameB64_rndBase64_chksumB64" 'http://localhost:8080/' |grep 'Hostname'
done

# and 10 more with data changed around the username
for i in {1..10}
do
  curl -s -X POST --header "Authorization: Bearer syt_UsernameB64_random64_checksum" 'http://localhost:8080/' |grep 'Hostname'
done

# and another 10 with different header
for i in {1..10}
do
  curl -s -X POST --header "Authorization: Bearer syt_AnotherB64_rndBase64_chksumB64" 'http://localhost:8080/' |grep 'Hostname'
done

# and 10 more with noncompliant header
for i in {1..10}
do
  curl -s -X POST --header "Authorization: Bearer randomrandomrandom" 'http://localhost:8080/' |grep 'Hostname'
done

#!/bin/bash
#set -euxo pipefail
set -euo pipefail

# do 10 requests with one header and printout which instance replied
username="UsernameB64"
echo "first test batch, username: ${username}"
for i in {1..10}
do
  curl -v -X POST --header "Authorization: Bearer syt_${username}_rndBase64_chksumB64" 'http://localhost:8080/' 2>&1 | grep '< X-'
done
echo ""

# and 10 more with data changed around the username
echo "second test batch, same user, different data around it"
for j in {1..10}
do
  curl -v -X POST --header "Authorization: Bearer syt_${username}_otherbase64_differentB64" 'http://localhost:8080/' 2>&1 | grep '< X-'
done
echo ""

# and another 10 with different header
username2="OtherUserB64"
echo "third test batch, another user: ${username2}"
for x in {1..10}
do
  curl -v -X POST --header "Authorization: Bearer syt_${username2}_rndBase64_chksumB64" 'http://localhost:8080/' 2>&1 | grep '< X-'
done

# and 10 more with noncompliant same header
noncompliant="RandomRandomRandom"
echo "fourth test batch, noncompliant header: ${noncompliant}"
for x in {1..10}
do
  curl -v -X POST --header "Authorization: Bearer ${noncompliant}" 'http://localhost:8080/' 2>&1 | grep '< X-'
done

# and still 10 more with noncompliant different headers
echo "fifth test batch, noncompliant different header on every test"
for x in {1..10}
do
  noncompliant=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w 20 | head -n 1)
  echo "Noncompliant random header: ${noncompliant}"
  curl -v -X POST --header "Authorization: Bearer ${noncompliant}" 'http://localhost:8080/' 2>&1 | grep '< X-'
done

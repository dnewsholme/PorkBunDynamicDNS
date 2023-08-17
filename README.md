# PorkBunDNS
A Powershell based method for updating dns records using porkbun api

# Run via docker container and pass in the following environment variables

|Name|Value|Example|
|---|---|---|
|porkbunapikey| This should be your api key from porkbun| pk1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|
|porkbunapisecret| Secret for your api key|sk1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|
|porkbundynamicdnsdomains| List of domains to update| example.com,subdomain.example.com,subdomain2.example.com|

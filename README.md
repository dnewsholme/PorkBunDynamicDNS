# PorkBunDynamicDNS
A Powershell based method for updating dns records using porkbun api.

![Porkbun](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlGfR-5h2F1Wnx1_sk_QCo8QIAeIGVTe8Uhrt6alsu&s)

## Run via docker container and pass in the following environment variables

|Name|Value|Example|
|---|---|---|
|porkbunapikey| This should be your api key from porkbun| pk1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|
|porkbunapisecret| Secret for your api key|sk1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|
|porkbundynamicdnsdomains| List of domains to update| example.com,subdomain.example.com,subdomain2.example.com|


## Run with docker
```
sudo docker pull dnewsholme/porkbundynamicdns:master
sudo docker run -e porkbunapikey="pk1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" -e porkbunapisecret="sk1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" -e porkbundynamicdnsdomains="example.com,subdomain.example.com" dnewsholme/porkbundynamicdns:master
```

## Docker Compose
    ---
    version: "2"
    services:
      porkbundynamicdns:
       image: dnewsholme/porkbundynamicdns:master
       container_name: porkbundynamicdns
       environment:
         - porkbunapikey= pk1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
         - porkbunapisecret= sk1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
         - porkbundynamicdnsdomains= example.com,subdomain.example.com
    restart: unless-stopped

## Kubernetes Deployment
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: porkbundynamicdns-deployment
      labels:
        app: porkbundynamicdns
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: porkbundynamicdns
      template:
        metadata:
          labels:
            app: porkbundynamicdns
        spec:
          containers:
            - name: porkbundynamicdns
              image: dnewsholme/porkbundynamicdns:master
              env:
               - name: porkbunapisecret
                 value: "sk1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
               - name: porkbunapikey
                 value: "pk1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
               - name: porkbundynamicdnsdomains
                 value: "example.com,subdomain.example.com"



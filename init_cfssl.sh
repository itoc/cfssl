#!/bin/bash

# Copy certificates from SSM
aws ssm get-parameter --name bpm-ca-intermediate-private-key --region ap-southeast-2 --with-decryption --output text --query Parameter.Value > /etc/cfssl/intermediate_ca-key.pem && \
aws ssm get-parameter --name bpm-ca-intermediate-public-key --region ap-southeast-2 --with-decryption --output text --query Parameter.Value > /etc/cfssl/intermediate_ca.pem && \

# Serve CFSSL
cfssl serve -address=0.0.0.0 -ca-key=/etc/cfssl/intermediate_ca-key.pem -ca=/etc/cfssl/intermediate_ca.pem
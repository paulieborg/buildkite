#!/bin/bash

aws cloudformation update-stack --output text --stack-name example-buildkite-resources \
  --template-body file://./buildkite_resources.yml --capabilities CAPABILITY_IAM

#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$SCRIPT_DIR/../.."
TARGET_DIR="$ROOT_DIR/target"

(cd $ROOT_DIR && mkdir -p $TARGET_DIR && cfoo templates/official/*.yml templates/*.yml > $TARGET_DIR/aws-stack.json)

# to use the official template: --template-url "https://s3.amazonaws.com/buildkite-aws-stack/aws-stack.json"

aws cloudformation update-stack --output text --stack-name juno-buildkite-dev \
  --template-body file://$TARGET_DIR/aws-stack.json \
  --capabilities CAPABILITY_IAM --parameters file://$SCRIPT_DIR/buildkite_agents.json

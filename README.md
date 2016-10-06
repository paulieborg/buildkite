This repository contains customized buildkite agents templates


## Prerequsit to generate cloudformation template 
- Ruby
- cfoo to generate cloudformation json file from yaml files

## Commands to Generate template
    gem install bundler
    bundle install

    mkdir -p target
    cfoo templates/*.yml templates/mappings.yml.template > target/aws-stack.json
    

This repository contains customized buildkite agents templates

## Extra Features compared to official buildkite templates
- Startup at least 1 agents at 8 AM and shutdown all at 8 PM. These values are customizable by set parameters: 
  - ScheduledUpRecurrence (default value: Default: 0 21 * * *)
  - ScheduledUpMinSize (default value: 1)
  - ScheduledUpDesiredSize (default value: 1)
  
  - ScheduledDownRecurrence (default value: Default: 0 9 * * *)
  - ScheduledDownMinSize (default value: 0)
  - ScheduledDownDesiredSize (default value: 0)
  
  NOTE: If there's build task waiting for agents, it will bring up agents as needed during night(default behavior of original template).
  
- Copy authorized_keys from s3 bucket and merge with the local file, which allows multiple user remote ssh login
  Specify value for parameter: AuthorizedUsersS3Path, the EC2 instance will copy and merge authorized_keys at:
  - Instance startup
  - Each hour
  
  Example value: s3://juno-buildkite-dev/authorized_keys

## Prerequsit to generate cloudformation template 
- Ruby
- cfoo to generate cloudformation json file from yaml files

## Commands to Generate template
    gem install bundler
    bundle install

    mkdir -p target
    cfoo templates/*.yml templates/mappings.yml.template > target/aws-stack.json
    

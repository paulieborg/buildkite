## Features of agents
- Auto shutdown agents at 8 PM and startup agents at 8 AM, and startup agents as needed during night
- Copy authorized_keys from s3 bucket and merge with the local file, which allows multiple user remote login

## Setup Agents
- Create required resources
  Run ./buildkite_resources_setup.sh to create policies and s3 buckets
     
       ./buildkite_resources_setup.sh
    
- Create agents stack
  Change the policy arn in buildkite_agents_stack.json if it changed, and run buildkite_agents_stack_setup.sh to create agents
   
       ./buildkite_agents_setup.sh
   
   
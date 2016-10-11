There are quite a few ways to lock down and secure BuildKite agents to only run the actions related to a specific pipeline or queue

## meta-data

The first is meta-data on the build-agent itself.
https://buildkite.com/docs/agent/agent-meta-data#isolating-agents-with-queues 
https://buildkite.com/docs/agent/queues
This is done via a configuration file or environment variable and you essentially **tag** the BuildKite Agent and refer to it when you define your pipeline job

`env BUILDKITE_AGENT_META_DATA="docker=true,ruby2=true" buildkite-agent start`
 
    steps:
      - command: "script.sh"
        agents:
          docker: "true"
          ruby2: "true"

## Securing Agents via Hooks

To ensure an agent is **ONLY** used for a specific action or repository build, there are a couple of approaches

### Command WhiteList

BuildKite Agents have a way of restricting the build command available on an agent using a "Command Whitelist"
https://buildkite.com/docs/agent/securing
This uses a pre-command hook to do a basic comparison using a standard shell condition

    #!/bin/bash
    set -eu
    if [[ "$BUILDKITE_COMMAND" != "script/deploy" ]]; then
      echo "$BUILDKITE_COMMAND not allowed"
      exit 1
    fi

### Pipeline Hooks

You can use a pre-checkout hook to check the value of the target repo and exit if it does not match a pre-defined value
https://buildkite.com/docs/agent/hooks
    
    #!/bin/bash
    set -eu

    REPO_NAME=$(grep -A1 '\[remote "origin"\]' .git/config | tail -n1 | sed 's/.*url = \(.*\)/\1/g')

    if [[ $(echo $"REPO_NAME" | grep liveaccounts-ops.git | echo $?) == 1 ]]; then
      echo "$REPO_NAME not allowed"
      exit 1
    fi





#!/bin/bash

# Kill any existing instances of "honkit serve"
ps -Af | grep node | grep "honkit serve" | awk '{print $2}' | xargs kill 2>/dev/null
if [ "$1" = "shutdown" ]; then echo "Goodbye!"; exit 0; fi;

# Launch the server
npx honkit serve . &

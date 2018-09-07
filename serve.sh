#!/bin/bash

# Kill any existing instances of "gitbook serve"
ps -Af | grep node | grep "gitbook serve" | awk '{print $2}' | xargs kill 2>/dev/null
if [ "$1" = "shutdown" ]; then echo "Goodbye!"; exit 0; fi;

# Launch the server
gitbook serve . &

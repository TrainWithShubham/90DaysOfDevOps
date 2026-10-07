#!/bin/bash

# A global variable
user="Admin"

test_scope() {
    local user="Habeeb"
    global_var="I leaked out!"
    echo "Inside function: User is $user"
}

test_scope
echo "Outside function: User is $user"
echo "Outside function: $global_var"
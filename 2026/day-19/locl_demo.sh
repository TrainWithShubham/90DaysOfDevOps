#!/bin/bash

my_function() {
    local name="Asma"
    echo "Inside function: $name"
}

my_function

echo "Outside function: $name"

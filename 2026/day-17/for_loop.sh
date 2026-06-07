#!/bin/bash

fruits=("apple" "banana" "orange" "mango" "strawberry")

for fruit in "${fruits[@]}"; do
    echo "Fruit: $fruit"
done

countries=("india","aus")

for country in "${countries[@]}";do
    echo "country: $country"
done
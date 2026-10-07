#!/bin/bash

greet(){
    echo "Hello $1!"
}

add(){
    sum=$(( $1 + $2 ))
    echo "$sum"
}

greet habeeb
add 5 10


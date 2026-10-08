#!/bin/bash

greet(){  
	echo "Hello, $1!"
}

add(){
	sum=$(( $1 + $2 ))
	echo "Sum is : $sum"
}

greet "Asma"
add 5 10

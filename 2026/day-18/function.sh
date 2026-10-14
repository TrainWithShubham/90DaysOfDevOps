#!/bin/bash


great() {

	name="$1"

	echo "Hello, $name"

}



add() {
	sum=$(($1 + $2))
	echo "toatal, $sum"


}

great "chaitanya"
add 33 33





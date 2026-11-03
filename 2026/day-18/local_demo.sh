#!/bin/bash


local_function() {

	local name="chaitanya"
	echo "after_local: $name"

}

global_function() {


	name="vivek"
	echo "after_global: $name"

}

local_function
echo "after local: $name"

global_function
echo "after global: $name"


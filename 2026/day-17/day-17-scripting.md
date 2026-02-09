# Shell Scripting: Loops, Arguments & Error Handling


## Challenge Tasks

### Task 1:
- Create for_loop.sh that:
  - Loops through a list of 5 fruits and prints each one
  - Create count.sh that:
  - Prints numbers 1 to 10 using a for loop
 Ans:
#!/bin/bash
#

for fruits in apple banana graps mango lichi 
do

echo $fruits
done

<img width="848" height="277" alt="image" src="https://github.com/user-attachments/assets/2cab502e-971c-45a8-88f8-7b1aeebc88a6" />

## Task 2:
- Create countdown.sh that:
  - Takes a number from the user
  - Counts down to 0 using a while loop
  - Prints "Done!" at the end

 #!/bin/bash
#
#While loop
#

read -p "Enter a number" number

while [ $number -ge 0 ]

do
	echo $number
	number=$((number-1))
	
done

echo "Done!"

<img width="733" height="227" alt="image" src="https://github.com/user-attachments/assets/1e9c1489-c774-4a84-bdbc-1a0a5dfa6f88" />





    


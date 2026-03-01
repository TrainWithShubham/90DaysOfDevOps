#!/bin/bash
echo  " $# "
echo " $@ "
echo " $0"
~            
2)
#!/bin/bash
 read -p " enter the number :" number
 echo " count down starts in "
  while [ $number -ge 0 ]
  do
         echo "$number  " 
         ((number--))
 done
 echo " done ! "
~                 
3)
#!/bin/bash
for i  in  {1..10}
do
        echo " $i "
done
4)


 #!/bin/bash
furits=("Apple" " Mango" "Banana" "Orange" "Grapes")
 for i in "${furits[@]}"
 do      echo " $i "
 done
5)      
 
#!/bin/bash
if [ -z "$1" ] ; then
        echo " plz enetr the jana near the ./greet(name)"
        exit 1
else
echo " hello $1 "

fi 
~        
6)

#!/bin/bash
set -e

mkdir /tmp/devops-test 2>/dev/null || echo "Folder already exists"
touch /tmp/devops-test/file.txt
7)
#!/bin/bash
if [ "$EUID" -ne 0 ]; then
 echo " your not root  " 
exit 1
else
  echo " your good to go  "
fi
packages=("nginx" "curl" "wget")
for packages in "${packages[@]}"
do
 echo " checking $packages .."
   if  dpkg -s $packages >/dev/null 2>&1; then
        echo  " the $packages i already installed " 
else
   echo " installing the $packages "
    sudo apt-get update -y >/dev/null
    sudo apt-get install $packages -y >/dev/null
   if dpkg -s $packages >/dev/null 2>&1; then
           echo " the packages is successfuly installed "
   else
           echo " faild to install "
   fi
   fi

   echo " *********** end ************ "
done



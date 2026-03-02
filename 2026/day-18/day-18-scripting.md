stem_info.sh
#!/bin/bash
 set -euo pipefail
 host_os_info (){
	 echo ""
	 echo " The HOST is $(hostname) "
	 source /etc/os-release
         echo "The OS is $PRETTY_NAME"
 }
system_uptime(){
	echo ""
	echo "  The SYSTEM UPTIME is" 
	         uptime
}
disk_usage (){
	echo ""
	echo " The DISK USAGE is "
	         df -h 
   }
   
memory_usage (){
	echo ""
	echo " The MEMORY USAGE IS "
	        free -h 
 }
cpu_usage (){
	echo ""
	echo " The current CPU USAGE "
	top -b -n 1 | head -n 5
}
main(){
	host_os_info
	system_uptime
	disk_usage
	memory_usage
	cpu_usage
}
main
2)
disk_check.sh
#!/bin/bash
check_disk(){
	echo " ********** getting the disk usage ************ "
	df -h| grep /
        echo " *********  end ********************** "	
} 
check_memory (){
	echo " ************* memory usage ***************"
	free -h
        echo " ************ end *********************** "	
}
main(){
	check_disk
	check_memory
}
main
3)
disk_check.sh
#!/bin/bash
check_disk(){
	echo " ********** getting the disk usage ************ "
	df -h| grep /
        echo " *********  end ********************** "	
} 
check_memory (){
	echo " ************* memory usage ***************"
	free -h
        echo " ************ end *********************** "	
}
main(){
	check_disk
	check_memory
}
main

4)  
strict_demo.sh 
#!/bin/bash
set -euo pipefail
#!/bin/bash

set -euo pipefail
read -p " enter the name :" name
echo "Testing set -u (undefined variable)"
echo "Value of name is: $name"

echo "Testing set -e (command failure)"
     ls -l 

echo " Testing set -o pipefail"
grep "hello" functions.sh | wc -l

echo "Script completed"

*************** end ***********************

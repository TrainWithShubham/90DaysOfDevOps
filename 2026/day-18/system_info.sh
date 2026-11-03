#!/bin/bash


show_hostname() {
        echo "====== HOST NAME & OS INF0 ======="
	echo "current hostname : $(hostname)"
	echo "os info          : $(uname -r)"


}

up_time() {

	echo -e "\n =========== UPTIME ================="

	uptime -p


}

disk_uses() {

	echo -e "\n ========= DISK USES ============"

	du -hsx * | sort -rh | head -5


}

memory() {

	echo -e "\n ========= MEMORY ========="
	free -h


}

cpu_consumpstion() {

        echo -e "\n ============ CPU CONSUMPTION ======"
	ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6

}

main() {


show_hostname
up_time
disk_uses
memory
cpu_consumpstion

}


main

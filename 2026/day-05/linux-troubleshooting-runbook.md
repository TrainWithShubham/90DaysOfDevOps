As per the task :

basic command:
**command : uname -a**
output  : Darwin keshavs-MacBook-Air.local 25.2.0 Darwin Kernel Version 25.2.0: Tue Nov 18 21:08:48 PST 2025; root:xnu-12377.61.12~1/RELEASE_ARM64_T8132 arm64

**command : lsb_release -a**
output: command not found ( as i'm using terminal mac os ) 

so instead i used 

**command : sw_vers**
output :  ProductName:		macOS
          ProductVersion:		26.2
          BuildVersion:		25C56

cpu/Memory :

**command : top**
output : Processes: 885 total, 2 running, 883 sleeping, 4168 threads            18:33:04
Load Avg: 1.59, 1.60, 1.77  CPU usage: 4.36% user, 2.54% sys, 93.8% idle
SharedLibs: 594M resident, 119M data, 86M linkedit.
MemRegions: 0 total, 0B resident, 335M private, 1524M shared.
PhysMem: 15G used (2538M wired, 3789M compressor), 361M unused.
VM: 393T vsize, 5268M framework vsize, 0(0) swapins, 0(0) swapouts.
Networks: packets: 17128676/16G in, 8939745/3521M out.
Disks: 26763847/487G read, 16055854/200G written.

PID    COMMAND      %CPU TIME     #TH    #WQ  #PORT MEM    PURG  CMPRS  PGRP
89247  Google Chrom 10.2 03:11:58 21     1    280   116M   0B    38M    95446
419    WindowServer 9.7  10:44:46 24     6    4286  731M-  80M+  196M   419

**command :ps -0 89247**
 output : PID TTY           TIME CMD
89247 ??       192:10.34 /Applications/Google Chrome.app/Contents/Frameworks/Go




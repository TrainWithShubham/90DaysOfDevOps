This is my Day-02 of my #90DaysOfDevOpschallenge 

Today my task is to understand linux-architecture in depth 

. But first I will explain what linux actually is then i'll move to tasks
Answer: Linux is an operating system just like windows or macOs
        Linux is very powerful OS if a website is running 24/7 that means its usually running on OS Linux 
        Linux focuses on control, speed, and stability. Instead of focusing on looks 
Linux works on ask architecture now many people say what is ask?

ASK is Application, Shell & Kernel 

1. Application (What you want to do)
   Applications are the programs you use.
Examples:
ls, cp, ps, nginx, docker, mysql
. Applications cannot directly talk to hardware.

2. Shell (How you ask)
   The shell is the middleman.
Example:
bash, sh
   What really happens:
   . Shell reads your command
   . Shell understands it
   . Shell passes the request to the kernel
Think of shell as:
A translator between human language and system language

3. Kernel (Who actually does the work)
The kernel is a boss 👑
. It Talks to CPU, memory, disk, network
. Creates and manages processes
. Decides which app gets CPU
. Handles system things
Without kernel a linux System is nothing 

A simple linux OS flow 
You → Application → Shell → Kernel → Hardware

Now let's move to our Day-02 tasks

1. The core components of Linux (kernel, user space, init/systemd)
Answer: . The kernel is the core of Linux.it directly talks to hardware like CPU, memory, and disk.it manages processes and system resources.
        . User space is where users and applications run. it includes commands, shells, and software like nginx or docker. user space requests services from          the kernel
        . Systemd is the core componet of Linux OS. systemd is the first process started when Linux restarts. It starts, stops, and manages system services.          it keeps the system running and handles service failures.

2. How processes are created and managed
Answer: When you run a command or start an application in Linux, the system creates a process for it. Each process is given a unique ID so the system can tr        ack it,the Linux kernel manages all processes by deciding when they run, how much CPU and memory they use, and when they should wait or stop.Once a         process finishes its work, the kernel cleans it up and frees the system resources, keeping Linux stable and efficient.       

3. What systemd does and why it matters    
Answer: systemd is the first process that starts when Linux restarts and is responsible for starting, stopping, and managing system services. It ensures tha        t important services run in the correct order and automatically restarts them if they fail. It matters because it keeps the system stable, helps
        troubleshoot issues through logs, and ensures applications stay running in various environments.

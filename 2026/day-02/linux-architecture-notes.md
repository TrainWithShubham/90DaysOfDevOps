1. **Core Components of Linux(Kernel,userspace,init/systemd)**
   
 * Kernel - The kernel is the heart of Linux and it talks directly to hardware
          - Users never interact with the kernel directly
 * Userspace - User space is where commands and applications run
              Ex : ls, pwd, cd, mKdir
             - User space programs ask the kernel to do work
 * init/systemd - Systemd starts and manages system services
                - The first program started when Linux boots
   
2. **How processes are created and managed**
   - A process is a running program
      When you run a command:
   - The shell asks the kernel to create a process
  
3. **What Does systemd Do?**
   systemd is responsible for:
   - Starting services during boot
   - Managing background programs
  
   **Why systemd is Important**
     - Helps find why a service failed
     - Makes system management easier

 4. **Common process states are**
     - Running : Process is using CPU
     - Sleeping : Waiting for input or time
     - Zombie : Process finished but not removed yet
   
 5. **5 Commands I use daily**
     1. ls - list everying that is in a directory(folder)
     2. mKdir - To create a directory we use it
     3. pwd - present working directory(exact location)
     4. cd - change directory to move from one directory to another directory
     5. touch newfile.txt - creates a file in Ubuntu  


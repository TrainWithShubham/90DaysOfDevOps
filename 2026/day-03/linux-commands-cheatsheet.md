Day 03 – Linux Commands Practice (Daily-Use Cheat Sheet)

In today's assignment, we will talk about the daily usable command which DevOps professionals use:-

🔹 1. Process Management (VERY important daily)
    
   Command                         Usage                     Why to use

1. ps                            ps aux                     See all running processes
2. top                           top                        Live CPU & memory usage
3. htop                          htop                       Better version of top
4. kill                          kill PID                   Stop a process
5. kill -9                       kill 9 PID                 Forcekill stuck process
6. pgrep                         pgrep nginx                Get PID by process name
7. pkill                         pkill nginx                Kill process by name
8. nohup                         nohup command &            Run process in background

  # 👉 Daily scenario: Jenkins, Docker, Java app, Nginx stuck → ps aux | grep, then kill # 



🔹 2. File System Commands (used ALL the time) 


  Basically used for Navigation in linux file systtem

  Command                           Usage

1. pwd                              present working directory
2. ls                               List files/folders
3. ls -l                            Detailed list
4. ls -a                            Show hidden files
5. cd                               Change directory 
6. cd ..                            Go back  to previous directory
7. ls -d                            List all the directories


    File & Directory Operations


     Command                          Usage                     Purpose

1. mkdir                            mkdir logs                  create directory
2. mkdir -p                         mkdir -p a/b/c              Create nested directories
3. touch                            touch file.txt              Create a file
4. cp                               cp a.txt b.txt              Copy file
5. cp -r                            cp -r dir1 dir2             Copy Directory
6. mv                               mv old new                  Rename/move
7. rm                               rm file.txt                 Delete file
8. rm -r                            rm -r dir                   Delete directory
9. rm -rf                           Dangerous                   Force Delete(not recommended)


    File Viewing (Daily logs & configs)

    Command                         Usage

1. cat                              View file   
2. less                             Scroll file
3. more                             Page-by-page
4. head                             top 10 results
5. tail                             bottom 10 results
6. tail -f                          Live logs




🔹 3. Networking & Troubleshooting (Cloud & DevOps daily)


    Command                         Usage                       Why
 
1. ip a                         Show IP address
2. ip r                         Show routing
3. ping                         ping google.com                 Connectivity check
4. wget                         Download files
5. curl                         curl http://IP:PORT             API / service check
6. netstat                      netstat -tulnp                  Check open ports
7. ss                           ss -tulnp                       Faster netstat  
8. telnet                       telnet IP PORT                  Port connectivity
9. hostname                     Show hostname
10. hostname -I                 Show server IP  

                # Jenkins not loading → ss -tulnp | grep 8080 #




🔹 4. Permissions & Ownership (Must-know)

    Command                         Usage

1. chmod                        chmod 755 file.sh
2. chmod +x                     Make script executable
3. chown                        Change ownership
4. ls -l                        Check permissions




🔹 5. Disk & System Info (Quick checks)


    Command                         Usage 
    
1.  df -h                       Disk usage
2.  du -sh                      Folder Size
3.  free -h                     Memory usage
4.  uptime                      Server uptime
5.  whoami                      Current logged in user
6.  uname -a                    OS info




                                One-liner commands



                ps aux | grep nginx
                tail -f app.log 
                df -h
                free -h
                ss -tulnp



✅ Why this cheat sheet is perfect for daily use

✔ Covers 90% real-world Linux usage
✔ DevOps / Cloud friendly
✔ No unnecessary theory
✔ Reusable for years

































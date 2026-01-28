Linux Internals – DevOps Foundation Notes

1. Core Components of Linux
  1) Kernal :-
       . kernal is heart of linux os.
       . kernal is talk with hardware. it's take command from shell and passout to hardware.
       . responsibilities :- 1] procces managment 2]memory managment 3]system calls

  2) User Space :-
       . Where applications and users live.
       . Includes:
          Shells (bash, zsh)
          Utilities (ls, ps, top)
          Services (nginx, docker)
       . Uses system calls to request work from the kernel.

  3) Init System (systemd) :-
       . After the kernel loads, it starts one special process: systemd.
       . The first process started by the kernel (PID = 1).
       . Manages system startup and services.
       . Modern Linux uses systemd as init.

2. systemd – Deep Understanding
   - What systemd Actually Does
      . systemd is a service manager + init system.
      . Responsibilities:
        -Starts services at boot
        -Stops services at shutdown
        -Restarts crashed services
        -Manages dependencies
        -Centralized logging

3. Daily Linux Commands (DevOps Essentials)
1️⃣ ps aux
  Snapshot of all processes
  See PID, CPU, memory

2️⃣ top / htop
  Live monitoring  
  CPU spikes, memory leaks

3️⃣ systemctl
  Start / stop / restart services
  systemctl restart docker

4️⃣ journalctl
  Logs for debugging
  journalctl -xe

5️⃣ kill
  Stop misbehaving processes
  kill -9 PID

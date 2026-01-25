** How process are created & managed **

 Everything in linux is a Process.
 New processes are created using:

fork() → creates a copy of the current process

exec() → replaces the process with a new program

Each process has:

PID (Process ID)

Parent PID (PPID)

State (running, sleeping, stopped, zombie)


** NOTE ** --> # Kernel schedules processes using CPU scheduling algorithm #
Commands :- top,htop,ps,kil etc


** What systemd does & why does it matter **

What systemd Does and Why It Matters
What systemd Does

Acts as the init system (PID 1).

Manages:

Services (.service)

Mount points (.mount)

Why systemd Matters:-

Centralized service management:

systemctl start|stop|restart service

Automatic service recovery (restart on failure).

Essential for servers, containers, and cloud environments.

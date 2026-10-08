# Process Commands

# ps aux (display all running prpcess in linux)

ps means processing status
a means all users
u means detailed user formate
x means show process without terminal/background process
ps aux = show all running process from all user with detailed information
It will shows PID process ID, CPU usage,Mem usage ,STAT process state

ps process status which shows current shells running process

# top -> use for real time sysetem monitoring

checks CPU Usage,Memory Usage,Runnning process , load process
top Live monitoring (shows process updating continously)

**ps aux static snapshot, take one time snapshot, command finished immediately. good for serching and checkinh (ps aux | grep nginx (to check is nginx running))
top realtime monitoring , continously refreshes, goog for troubleshootinhg CPU/memory issue(High CPU issue, memory leak,server slownes)**

# htop | Interactive process viewer |

# kill PID | Stop process | you have to find out PID process ID whatever you want to kill (ps aux command)

kill 3200
it will help to stop stuck process

# kill -9 PID | Force stop process |

Forcefully stop/terminate process immediately.
Forcefully destroy process
kill -9 is powerful because:
process cannot ignore it
kernel immediately terminates process But use this command carefullu because unsaved data may be lost
,application may not cleanup properly

# File Commands

# | ls | List files |

# | pwd | Show current directory |

# | cd | Change directory |

# | mkdir | Create folder |

# | rm -rf | Remove files/folders |

# | cp | Copy files |

# | mv | Move/rename files |

# | touch | Create empty file |

# | cat | View file content |

# | nano | Edit file |

# Networking Commnads

ping google.com -->check connectivity

ip addr -->show Ip Address

curl website.com --> test http request

netstat -tulnp --> check open ports

ss -tulnp ---> View Listening ports

dig google.com ---> DNS lookup

## Log & Service Commands

| journalctl | View logs |
| journalctl -u nginx | Service logs |
| systemctl status nginx | Service status |
| systemctl restart nginx | Restart service |
| df -h | Disk usage |
| free -m | Memory usage |

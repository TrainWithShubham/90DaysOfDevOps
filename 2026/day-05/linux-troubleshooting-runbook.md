This report provides a snapshot of the current server state, focusing on identifying performance bottlenecks.
1. Target Service / Process 

• Service/Process Name: [e.g., apache2, mysql, java, docker-proxy] 
• PID: [Use  or  to find] 
• Status: [Running/Stopped/Zombie/High Resource Usage] 

2. Snapshot: CPU & Memory 

• Load Average (1m, 5m, 15m): [Run ] 
• Top CPU Consumers: [Run  or ] 
• Memory Usage (Free/Used/Buff/Cache): [Run ] 
• Swap Usage: [If non-zero and increasing, memory pressure is critical]  

3. Snapshot: Disk & IO 

• Disk Space Availability: [Run  to check for 100% usage] 
• Disk IOPS/Wait: [Run  or  to check high  or ] 
• Inode Usage: [Run ] [13, 14, 15, 16]  

4. Snapshot: Network 

• Network Utilization: [Run  or ] 
• Connections: [Run  or  to check for high connection counts] 
• Latency: [Run  or  to verify external connectivity] 

5. Logs Reviewed 

• System Messages:  or  
• Service Logs:  
• Auth Logs:  (if security breach is suspected) [21]  

6. Quick findings for this Environment 

• OS/Kernel: [Run  and ] 
• Bottleneck Identified: [CPU / Memory / Disk IO / Network / Service failure] 
• Immediate Action: [e.g., Restart service, purge logs, kill high-resource PID] 

If this worsens (next steps) 

1. Deeper Diagnostics: Use  on the PID to analyze system calls. 
2. Performance Logging: Enable  or  to capture long-term trends. 
3. Kernel Parameters: Check  settings (e.g., max open files, memory overcommit). 
4. Hardware Check: Verify physical disk health using  (if bare metal).










